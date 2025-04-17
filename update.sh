gcloud compute scp --project "linear-enigma-289302" --zone "us-central1-c" --recurse ./digdag umehara-katsuya@instance-20250320-074925:/home/umehara-katsuya
gcloud compute scp --project "linear-enigma-289302" --zone "us-central1-c" --recurse ./compose.yaml umehara-katsuya@instance-20250320-074925:/home/umehara-katsuya

gcloud compute ssh --zone "us-central1-c" "instance-20250320-074925" --project "linear-enigma-289302"
