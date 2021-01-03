
export const timeSince: (date: Date) => string = (date) => {
    return date.toUTCString()
}

// export const onInput: (event: Event, filler: () => void) = 
//     (event, filler) => filler(event.target.value)