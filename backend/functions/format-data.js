const isEmail = function (contact) {
  return /\S+@\S+\.\S+/.test(contact);
};

const isPhone = function (contact) {
  return /^\+?([0-9]{2})\)?[-. ]?([0-9]{4})[-. ]?([0-9]{4})$/.test(contact);
};

module.exports = {
  isUser(path) {
    if (path.match("/signup/user") != null) return true;
    if (path.match("/signup/buyer") != null) return false;
    else return null;
  },

  sanitize(contact) {
    return contact.trim().toLowerCase();
  },

  contactType(contact) {
    if (isEmail(contact)) return "email";
    else if (isPhone(contact)) return "phone";
    else return "unknown";
  },

  contactTypePinpoint(contact) {
    if (isEmail(contact)) return "EMAIL";
    else return "SMS";
  },
};
