/**
 * @file pkmn_gym.c
 * @author Katniss
 *
 * @date 2024-03-20
 */

// DO NOT MODIFY THE INCLUDE(S) LIST
#include "pkmn_gym.h"

// DO NOT MODIFY THE GLOBAL VARIABLE(S) LIST
struct Gym gym;

// ALWAYS check the validity of the passed in arguments
// (i.e. not NULL, in the correct range, not too long)

// If any of the parameters are invalid, the function should
// do nothing and return FAILURE.


/** register_trainer
 * @brief Add a new trainer to the gym with the provided parameters.
 * @param name the name of the trainer
 * @return FAILURE if parameters invalid or the gym is full, SUCCESS otherwise
*/
int register_trainer(const char *name) {
    if (name == NULL || *name == '\0') {
        return FAILURE;
    }

    if (gym.num_trainers >= MAX_TRAINER_LENGTH) {
        return FAILURE;    // full gym
    }

    if (my_strlen(name) >= MAX_NAME_LENGTH) {
        return FAILURE;
    }

    my_strncpy(gym.trainers[gym.num_trainers].name, name, MAX_NAME_LENGTH);
    gym.num_trainers++;
    return SUCCESS;
}


/** unregister_trainer
 * @brief Removes a trainer from the gym.
 * @param name the name of the trainer
 * @return FAILURE if parameters invalid or the trainer is not found, SUCCESS otherwise
*/
int unregister_trainer(const char *name) {
    if (name == NULL || *name == '\0') {
        return FAILURE;
    }

    int find = 0;
    int i;

    for (i = 0; i < gym.num_trainers; i++) {
        if(my_strncmp(gym.trainers[i].name, name, MAX_NAME_LENGTH) == 0) {
            find = 1;
            break;
        }
    }

    if(!find) {
        return FAILURE;
    }

    for (int j = i; j < gym.num_trainers - 1; j++) {
        gym.trainers[j] = gym.trainers[j + 1];
    }
    gym.num_trainers--;
    
    return SUCCESS;
}

/** catch_pokemon
 * @brief Creates a new Pokémon and adds it to
 * the trainer's party.
 * @param trainer pointer to the trainer who caught this Pokémon
 * @param species the species of the Pokémon caught
 * @param level the level of the Pokémon caught
 * @return FAILURE if parameters invalid or the trainer's party is full, SUCCESS otherwise
*/
int catch_pokemon(struct Trainer *trainer, const char *species, int level) {
    if (trainer == NULL || species == NULL || *species == '\0') {
        return FAILURE;
    }

    if (level < 1 || level > 100) {
        return FAILURE;
    }

    if (trainer->party_size >= MAX_PARTY_LENGTH) {
        return FAILURE;
    }

    if (my_strlen(species) >= MAX_NAME_LENGTH) {
        return FAILURE;
    }

    my_strncpy(trainer->party[trainer->party_size].species, species, MAX_NAME_LENGTH);
    trainer->party[trainer->party_size].level = level;
    trainer->party_size++;

    return SUCCESS;
}


/** release_pokemon
 * @brief Removes a Pokémon from a trainer's party.
 * @param trainer pointer to the trainer who is releasing a Pokémon
 * @param species the species of the Pokémon to release
 * @return FAILURE if parameters invalid or the Pokémon is not found in the trainer's party, SUCCESS otherwise
*/
int release_pokemon(struct Trainer *trainer, const char *species) {
    if (trainer == NULL || species == NULL) {
        return FAILURE;
    }

    int found = 0;
    int i;

    for (i = 0; i < trainer->party_size; i++) {
        if (my_strncmp(trainer->party[i].species, species, MAX_NAME_LENGTH) == 0) {
            found = 1;
            break;
        }
    }

    if (!found) {
        return FAILURE;
    }

    for (int j = i; j < trainer->party_size - 1; j++) {
        trainer->party[j] = trainer->party[j + 1];
    }

    trainer->party_size--;
    return SUCCESS;
}


/** count_species
 * @brief Count the total number of Pokémon of a given species
 * out of the parties of every trainer in this gym.
 * @param species the name of the species to search for
 * @return FAILURE if parameters invalid, otherwise the number of Pokémon in the gym of the given species
*/
int count_species(const char *species) {
    if (species == NULL || my_strlen(species) >= MAX_NAME_LENGTH) {
        return FAILURE;
    }

    int total_count = 0;

    for (int i = 0; i < gym.num_trainers; i++) {
        struct Trainer *trainer = &gym.trainers[i];

        for (int j = 0; j < trainer->party_size; j++) {
            if (my_strncmp(trainer->party[j].species, species, MAX_NAME_LENGTH) == 0) {
                total_count++;
            }
        }
    }

    return total_count;
}


/** trade_pokemon
 * @brief Trade two Pokémon between two trainers,
 * swapping their positions in their parties.
 * @param t0 pointer to the first trainer in the trade
 * @param party_index_0 the index of the Pokémon to trade in the first trainer's party
 * @param t1 pointer to the second trainer in the trade
 * @param party_index_1 the index of the Pokémon to trade in the second trainer's party
 * @return FAILURE if 
 *                  parameters invalid,
 *                  both Trainers are the same,
 *                  party_index_0 or party_index_1 do not point to pokemon,
 *         SUCCESS otherwise
*/
int trade_pokemon(struct Trainer *t0, int party_index_0, struct Trainer *t1, int party_index_1) {
    if (t0 == t1) {
        return FAILURE;
    }

    if (t0 == NULL || t1 == NULL) {
        return FAILURE;
    }

    if (party_index_0 < 0 || party_index_0 >= t0->party_size) {
        return FAILURE;
    }

    if (party_index_1 < 0 || party_index_1 >= t1->party_size) {
        return FAILURE;
    }

    struct Pokemon temp = t0->party[party_index_0];
    t0->party[party_index_0] = t1->party[party_index_1];
    t1->party[party_index_1] = temp;

    return SUCCESS;
}


/** battle_trainer
 * @brief Start a battle between two trainers.
 * 
 * The num_wins variable of the winner of this battle should
 * also be incremented to reflect the trainer's win.
 * 
 * @param challenger pointer to the trainer who initiated the battle
 * @param opponent pointer to the trainer who was initiated by the challenger
 * @return FAILURE if parameters invalid, 0 if the challenger wins, 1 if the opponent wins
*/
int battle_trainer(struct Trainer *challenger, struct Trainer *opponent) {
    if (challenger == NULL || opponent == NULL) {
        return FAILURE;
    }

    int challenger_wins = 0;
    int opponent_wins = 0;

    int num_matches;
    if (challenger->party_size < opponent->party_size) {
        num_matches = challenger->party_size;
    } else {
        num_matches = opponent->party_size;
    }

    for (int i = 0; i < num_matches; i++) {
        int challenger_level = challenger->party[i].level;
        int opponent_level = opponent->party[i].level;

        if (challenger_level > opponent_level) {
            challenger_wins++;
        } else if (challenger_level < opponent_level) {
            opponent_wins++;
        }
    }

    if (challenger->party_size > opponent->party_size) {
        challenger_wins += challenger->party_size - num_matches;
    } else if (opponent->party_size > challenger->party_size) {
        opponent_wins += opponent->party_size - num_matches;
    }

    int winner;
    if (challenger_wins > opponent_wins) {
        winner = 0;
        challenger->num_wins++;
    } else {
        winner = 1;
        opponent->num_wins++;
    }

    return winner;
}


/** find_champion
 * @brief Find the CHAMPION!!! (i.e., the trainer in this gym with the most wins.)
 * If several trainers have the maximum number of wins, pick the first in the gym trainer array with
 *  the maximum wins.
 * @return a pointer to the Trainer with the most wins, NULL is the gym has no Trainers in it
*/
struct Trainer *find_champion(void) {
    if (gym.num_trainers == 0) {
        return NULL;
    }

    struct Trainer *champion = &gym.trainers[0];
    int max_wins = champion->num_wins;

    for (int i = 1; i < gym.num_trainers; i++) {
        struct Trainer *current_trainer = &gym.trainers[i];
        
        if (current_trainer->num_wins > max_wins) {
            champion = current_trainer;
            max_wins = current_trainer->num_wins;
        }
    }

    return champion;
}
