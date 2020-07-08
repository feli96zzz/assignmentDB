using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BTL
{
    class UserDTO
    {
        private int id  ;
        public int Id
        {
            get { return id; }
            set { id = value; }
        }
        private string name;
        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        private string description;
        public string Description
        {
            get { return description; }
            set { description = value; }
        }
        private string status;
        public string Status
        {
            get { return status; }
            set { status = value; }
        }
        private string detailedInfo;
        public string DetailedInfo
        {
            get { return detailedInfo; }
            set { detailedInfo = value; }
        }
        private string brand;
        public string Brand
        {
            get { return brand; }
            set { brand = value; }
        }
        private string type;
        public string Type
        {
            get { return type; }
            set { type = value; }
        }
    }
}
