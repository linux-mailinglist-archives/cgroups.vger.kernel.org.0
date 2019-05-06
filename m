Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B19F8148D9
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2019 13:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfEFLXg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 May 2019 07:23:36 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:53722 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbfEFLXg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 May 2019 07:23:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TR1QR2k_1557141813;
Received: from ali-186590e05fa3.local(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0TR1QR2k_1557141813)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 May 2019 19:23:33 +0800
Subject: Re: [PATCH] overlayfs: check the capability before cred overridden
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, joseph.qi@linux.alibaba.com
References: <20190506074102.87444-1-jiufei.xue@linux.alibaba.com>
 <CAOQ4uxgptpGyaG5-Wtr8v6SnAvYqXQ-fkmkM0Cjg0jJzij4b8w@mail.gmail.com>
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
Message-ID: <aa350616-daea-971b-5696-076defba8ad3@linux.alibaba.com>
Date:   Mon, 6 May 2019 19:23:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxgptpGyaG5-Wtr8v6SnAvYqXQ-fkmkM0Cjg0jJzij4b8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Amir,

On 2019/5/6 下午6:51, Amir Goldstein wrote:
> On Mon, May 6, 2019 at 10:41 AM Jiufei Xue <jiufei.xue@linux.alibaba.com> wrote:
>>
>> We found that it return success when we set IMMUTABLE_FL flag to a
>> file in docker even though the docker didn't have the capability
>> CAP_LINUX_IMMUTABLE.
>>
>> The commit d1d04ef8572b ("ovl: stack file ops") and
>> dab5ca8fd9dd ("ovl: add lsattr/chattr support") implemented chattr
>> operations on a regular overlay file. ovl_real_ioctl() overridden the
>> current process's subjective credentials with ofs->creator_cred which
>> have the capability CAP_LINUX_IMMUTABLE so that it will return success
>> in vfs_ioctl()->cap_capable().
>>
>> Fix this by checking the capability before cred overriden. And here we
>> only care about APPEND_FL and IMMUTABLE_FL, so get these information from
>> inode.
> 
> Good idea. My idea was less good ;-)
> See one minor comment below.
> 
> Will you be able to write an xfstest to cover this bug?
> See for reference tests/generic/159 and tests/generic/099
>

Good suggestion. I will write the testcase and send to xfstests-dev later.

> Thanks,
> Amir.
> 
>>
>> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
>> ---
>>  fs/overlayfs/file.c | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
>> index 84dd957efa24..fecf1b43b6fe 100644
>> --- a/fs/overlayfs/file.c
>> +++ b/fs/overlayfs/file.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/mount.h>
>>  #include <linux/xattr.h>
>>  #include <linux/uio.h>
>> +#include <linux/uaccess.h>
>>  #include "overlayfs.h"
>>
>>  static char ovl_whatisit(struct inode *inode, struct inode *realinode)
>> @@ -372,10 +373,30 @@ static long ovl_real_ioctl(struct file *file, unsigned int cmd,
>>         return ret;
>>  }
>>
>> +static unsigned int ovl_get_inode_flags(struct inode *inode)
>> +{
>> +       unsigned int flags = READ_ONCE(inode->i_flags);
>> +       unsigned int ovl_iflags = 0;
>> +
>> +       if (flags & S_SYNC)
>> +               ovl_iflags |= FS_SYNC_FL;
>> +       if (flags & S_APPEND)
>> +               ovl_iflags |= FS_APPEND_FL;
>> +       if (flags & S_IMMUTABLE)
>> +               ovl_iflags |= FS_IMMUTABLE_FL;
>> +       if (flags & S_NOATIME)
>> +               ovl_iflags |= FS_NOATIME_FL;
>> +       if (flags & S_DIRSYNC)
>> +               ovl_iflags |= FS_DIRSYNC_FL;
> 
> Since ovl_copyflags() does not copy FS_DIRSYNC_FL, I don't think ovl
> inode can have FS_DIRSYNC_FL set.
> If you think that is important, you can add it to copied flags.
>

I don't think it is necessary to modify the ovl_copyflags() at least in
this scenario. We can add it when needed. I will remove the FS_DIRSYNC_FL
here to keep consistent.

Thanks,
Jiufei

>> +
>> +       return ovl_iflags;
>> +}
>> +
>>  static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>  {
>>         long ret;
>>         struct inode *inode = file_inode(file);
>> +       unsigned int flags;
>>
>>         switch (cmd) {
>>         case FS_IOC_GETFLAGS:
>> @@ -386,6 +407,15 @@ static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>                 if (!inode_owner_or_capable(inode))
>>                         return -EACCES;
>>
>> +               if (get_user(flags, (int __user *) arg))
>> +                       return -EFAULT;
>> +
>> +               /* Check the capability before cred overridden */
>> +               if ((flags ^ ovl_get_inode_flags(inode)) & (FS_APPEND_FL | FS_IMMUTABLE_FL)) {
>> +                       if (!capable(CAP_LINUX_IMMUTABLE))
>> +                               return -EPERM;
>> +               }
>> +
>>                 ret = mnt_want_write_file(file);
>>                 if (ret)
>>                         return ret;
>> --
>> 2.19.1.856.g8858448bb
>>
