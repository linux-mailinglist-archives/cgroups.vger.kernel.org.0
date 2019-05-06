Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78F1814894
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2019 12:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfEFKvr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 May 2019 06:51:47 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35499 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfEFKvr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 May 2019 06:51:47 -0400
Received: by mail-yw1-f67.google.com with SMTP id n188so9980971ywe.2;
        Mon, 06 May 2019 03:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebYDWSQFvx/dwekUHwDxt+/wWoIBGKgLR8/hx0WbrsE=;
        b=PF/T7sZATjgH74FlLtPplA1ho3iSxxEMgSAknZvBUu9XZxW+kMJmFSa/w/JHfLnEB4
         kl+JlJJoMvkzie+E5drh1P4QAAIdKqo8qQU7P+RJ1ne7G/V4qGenvnZNRuvuZ5YPhNnc
         ShWBliz/Rf5DVkNLabzLy+zdrqeX0B9E9o/vfWNCK80kTpcFGEPFhptbsp12/YEiUqtt
         QRMQwnquDbVWEa4C4L8xOsJLmBxfn7KkST14BhnzDTcV/AAMBErHIq8QzuoebVMWNioC
         7Pc+SYnNwlIdbg7qGc/Q2CNDxm0VVEnz3vAopTHRL5ILQzGOnoXYbLHGLAxNF/pjW5wa
         N89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebYDWSQFvx/dwekUHwDxt+/wWoIBGKgLR8/hx0WbrsE=;
        b=V2a985DLn5r42UpCM7pgtobSHwsKIUXzPvZ2p/8HCL5oKqlt9L7+pP9m44Pms2wzI6
         HkzfwSGDDEumFNT0MxNzhJAnGwKixnCYUJHcmylIXgAlx+4MQZKMxZ2YTzmv6uizC7vQ
         GkYYNihlO+xXYrXWH1qYm3sKdGrMZhFsae8Lwk4s3Zn47cOdZlGspQ7UeE3XDBm7nrIV
         xPZtRRX1plRNPXPfQZfKzMcdctqxQR2ck7qOEgXMa2rkKZwuIbeNBnPV9ov55cmu2N7z
         r5TXJLoUB2Avf2UoSsrdOWS4+m9105MC5LjsP1dCeo5lmxuFxRAri1Wbs/X5yHmNLN79
         yDpQ==
X-Gm-Message-State: APjAAAUyPwCQZo6eZQxLPO4FaDbI4ihwD2nwTMFMjyyT7quMbghPOZxC
        XgvbZk8O+9X4khqfnQEdWGJDL3RmdZgf0GDBbBhZc1o8
X-Google-Smtp-Source: APXvYqwmlY2jF/Y0NfYB/8p7YmS7+fhyOIClISKtNsrz1IsVAnUKwPi4uK+KqRjCbFBZrmKvSPW/1UXZwBt5sdclYmk=
X-Received: by 2002:a81:5fc4:: with SMTP id t187mr15966423ywb.34.1557139906479;
 Mon, 06 May 2019 03:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190506074102.87444-1-jiufei.xue@linux.alibaba.com>
In-Reply-To: <20190506074102.87444-1-jiufei.xue@linux.alibaba.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 6 May 2019 13:51:35 +0300
Message-ID: <CAOQ4uxgptpGyaG5-Wtr8v6SnAvYqXQ-fkmkM0Cjg0jJzij4b8w@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: check the capability before cred overridden
To:     Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, joseph.qi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 6, 2019 at 10:41 AM Jiufei Xue <jiufei.xue@linux.alibaba.com> wrote:
>
> We found that it return success when we set IMMUTABLE_FL flag to a
> file in docker even though the docker didn't have the capability
> CAP_LINUX_IMMUTABLE.
>
> The commit d1d04ef8572b ("ovl: stack file ops") and
> dab5ca8fd9dd ("ovl: add lsattr/chattr support") implemented chattr
> operations on a regular overlay file. ovl_real_ioctl() overridden the
> current process's subjective credentials with ofs->creator_cred which
> have the capability CAP_LINUX_IMMUTABLE so that it will return success
> in vfs_ioctl()->cap_capable().
>
> Fix this by checking the capability before cred overriden. And here we
> only care about APPEND_FL and IMMUTABLE_FL, so get these information from
> inode.

Good idea. My idea was less good ;-)
See one minor comment below.

Will you be able to write an xfstest to cover this bug?
See for reference tests/generic/159 and tests/generic/099

Thanks,
Amir.

>
> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
> ---
>  fs/overlayfs/file.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 84dd957efa24..fecf1b43b6fe 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -11,6 +11,7 @@
>  #include <linux/mount.h>
>  #include <linux/xattr.h>
>  #include <linux/uio.h>
> +#include <linux/uaccess.h>
>  #include "overlayfs.h"
>
>  static char ovl_whatisit(struct inode *inode, struct inode *realinode)
> @@ -372,10 +373,30 @@ static long ovl_real_ioctl(struct file *file, unsigned int cmd,
>         return ret;
>  }
>
> +static unsigned int ovl_get_inode_flags(struct inode *inode)
> +{
> +       unsigned int flags = READ_ONCE(inode->i_flags);
> +       unsigned int ovl_iflags = 0;
> +
> +       if (flags & S_SYNC)
> +               ovl_iflags |= FS_SYNC_FL;
> +       if (flags & S_APPEND)
> +               ovl_iflags |= FS_APPEND_FL;
> +       if (flags & S_IMMUTABLE)
> +               ovl_iflags |= FS_IMMUTABLE_FL;
> +       if (flags & S_NOATIME)
> +               ovl_iflags |= FS_NOATIME_FL;
> +       if (flags & S_DIRSYNC)
> +               ovl_iflags |= FS_DIRSYNC_FL;

Since ovl_copyflags() does not copy FS_DIRSYNC_FL, I don't think ovl
inode can have FS_DIRSYNC_FL set.
If you think that is important, you can add it to copied flags.

> +
> +       return ovl_iflags;
> +}
> +
>  static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>         long ret;
>         struct inode *inode = file_inode(file);
> +       unsigned int flags;
>
>         switch (cmd) {
>         case FS_IOC_GETFLAGS:
> @@ -386,6 +407,15 @@ static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>                 if (!inode_owner_or_capable(inode))
>                         return -EACCES;
>
> +               if (get_user(flags, (int __user *) arg))
> +                       return -EFAULT;
> +
> +               /* Check the capability before cred overridden */
> +               if ((flags ^ ovl_get_inode_flags(inode)) & (FS_APPEND_FL | FS_IMMUTABLE_FL)) {
> +                       if (!capable(CAP_LINUX_IMMUTABLE))
> +                               return -EPERM;
> +               }
> +
>                 ret = mnt_want_write_file(file);
>                 if (ret)
>                         return ret;
> --
> 2.19.1.856.g8858448bb
>
