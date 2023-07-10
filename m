Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0F274DD8A
	for <lists+cgroups@lfdr.de>; Mon, 10 Jul 2023 20:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjGJSnP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jul 2023 14:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjGJSnO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jul 2023 14:43:14 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC73C137
        for <cgroups@vger.kernel.org>; Mon, 10 Jul 2023 11:43:12 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b71cdb47e1so4321992a34.2
        for <cgroups@vger.kernel.org>; Mon, 10 Jul 2023 11:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689014592; x=1691606592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYRuesch5+38l9pcAr9ykkVr7diDWpCsFfENU0WyrxE=;
        b=S/q3ZU3Iydew6W5Z9meqNFt+b36KVi/V6IUz0VW9joILZuKQOnZKUKxuc6/DSRdaCS
         rgTpNyPWZ6/2lVacY5oQrZdeWSa9vrpXq4jRcP3L5qfmmOrxLAd/49EyYw87VpyEzSJr
         NA/HWAn0d5BWsQF9Rd+n2P3KPTcwmzYWlFUmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689014592; x=1691606592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYRuesch5+38l9pcAr9ykkVr7diDWpCsFfENU0WyrxE=;
        b=gwjCGchdEDEDveN/Vc9+c4pkb4IEQHJqeyrQqzBdX95ZuaommHH/YOiNHuWeP32Kmo
         JPiPCwRiFSeWjq62Jij5O4RaLhGctesDXfKXli/McmLBAnFl09sgEzaCt3LzcZkt9W48
         QU2H1d1g/Qb86ZzNlNyJQ5t3K6JQe8KHg52SVFXvxTr07A1cGN7J5jDmJx5sApc0y88Z
         24o+17Lmu0QwH3BuK1by9XYts+7A6XAC3/ydVvnzGW/PGNm+tIeSCtComGIzPM7L2isP
         T2jffwV1pIeCi6JNhMa0wn7lRaS/3bYIBLg1oIlzBcSOWhDgWh36hTpVp4dWF8kovU38
         Y1Qw==
X-Gm-Message-State: ABy/qLbZaBobachyHcp0hcKLFvR7IMPgevSrUQrjBIZftGl3ji8E763U
        xntEOO0aVWvRlzHcZeprF761YHdH8tHiVpCvKP06Sg==
X-Google-Smtp-Source: APBJJlED49EO34FhVNwhQ+NxWBSctE13//uU3m5zTHrEBzMkJVcfAl5JGNpBgYHAgLhfJ9wKZ440QUWoioct4gkWGT4=
X-Received: by 2002:a05:6870:f6a2:b0:1b0:89e0:114f with SMTP id
 el34-20020a056870f6a200b001b089e0114fmr13970388oab.31.1689014592052; Mon, 10
 Jul 2023 11:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230710183338.58531-1-ivan@cloudflare.com>
In-Reply-To: <20230710183338.58531-1-ivan@cloudflare.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Mon, 10 Jul 2023 19:43:00 +0100
Message-ID: <CALrw=nHZhczbY0BOOieTCMnYM8AnobU4ka+wfoOO+uxA9=pMjw@mail.gmail.com>
Subject: Re: [PATCH] kernfs: attach uuid for every kernfs and report it in fsid
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@cloudflare.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 10, 2023 at 7:33=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> w=
rote:
>
> The following two commits added the same thing for tmpfs:
>
> * commit 2b4db79618ad ("tmpfs: generate random sb->s_uuid")
> * commit 59cda49ecf6c ("shmem: allow reporting fanotify events with file =
handles on tmpfs")
>
> Having fsid allows using fanotify, which is especially handy for cgroups,
> where one might be interested in knowing when they are created or removed=
.
>
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> ---
>  fs/kernfs/mount.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index d49606accb07..930026842359 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -16,6 +16,8 @@
>  #include <linux/namei.h>
>  #include <linux/seq_file.h>
>  #include <linux/exportfs.h>
> +#include <linux/uuid.h>
> +#include <linux/statfs.h>
>
>  #include "kernfs-internal.h"
>
> @@ -45,8 +47,15 @@ static int kernfs_sop_show_path(struct seq_file *sf, s=
truct dentry *dentry)
>         return 0;
>  }
>
> +int kernfs_statfs(struct dentry *dentry, struct kstatfs *buf)

This probably should be declared static

> +{
> +       simple_statfs(dentry, buf);
> +       buf->f_fsid =3D uuid_to_fsid(dentry->d_sb->s_uuid.b);
> +       return 0;
> +}
> +
>  const struct super_operations kernfs_sops =3D {
> -       .statfs         =3D simple_statfs,
> +       .statfs         =3D kernfs_statfs,
>         .drop_inode     =3D generic_delete_inode,
>         .evict_inode    =3D kernfs_evict_inode,
>
> @@ -351,6 +360,8 @@ int kernfs_get_tree(struct fs_context *fc)
>                 }
>                 sb->s_flags |=3D SB_ACTIVE;
>
> +               uuid_gen(&sb->s_uuid);
> +
>                 down_write(&root->kernfs_supers_rwsem);
>                 list_add(&info->node, &info->root->supers);
>                 up_write(&root->kernfs_supers_rwsem);
> --
> 2.41.0
>

Ignat
