Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB3940D3D4
	for <lists+cgroups@lfdr.de>; Thu, 16 Sep 2021 09:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhIPHfW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Sep 2021 03:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbhIPHfV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Sep 2021 03:35:21 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A70C061574;
        Thu, 16 Sep 2021 00:34:01 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id x2so5656611ila.11;
        Thu, 16 Sep 2021 00:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Bb9J2o84T3V9+Tf1rBXjmsTxCOrWhxebCsVPY9V9H3Q=;
        b=o7Hc/0r4/rqQZyDLh4oEdpb5eQFXFhD0EjPpk5hn/2A+g/usJSxSnLmJafVUoT38Zj
         8053Lv2OJY+wJyx+T0HEQgk3aFYMyzIw1m+wWScYol/9TSMGOTP/A1VCHz0yCXVOp9Io
         LzwSUt3Eqyfb9klM81ai+mwwcLv89gsJTUm30A8VQZpgs3tdG2nyb5yB+tOqxPfV5Yz4
         0TySfqplMUy9HvWeFvDi1pe+KyceI3mU/9146Shy6A8qUTYXeVgz6bn6Zu6L/aTARQwd
         4YJtIfql+wrNd11IzdnxdSk7yBqGnmPAMWP5VTHc7nrZ7PeI/dsinYip+3qzTTuBTK74
         hPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Bb9J2o84T3V9+Tf1rBXjmsTxCOrWhxebCsVPY9V9H3Q=;
        b=tHTMq22fqK0BENcVw2qFz9n5V0ke1IbUYkyumMtkFzazvltLqee1vicvcwKCiA6nks
         OXQFKnmhHnjIesMB89KyZBupajmQUaZGH1RSqEO8T5cU4bcKgLq2XsQTVQvVtupOMVGa
         1ZVD0TGjsrJNBXo2zUgaYX2eS98qem6h+nPP8TZrZgQGxX/DP+kcY99yObxelGpFU6jm
         Fbz+BWc5/Vsr8YiYQvWtENLB45dAyPZb3TY+Q2KpE1DZJQlkLshLWLyYLIhUyBr3sPx0
         +sKepywqIHIpPp9Gf0INXoDs0nELknG69xucbmbm2zj3Hc5LKGNyTBFjPvS5M9JQmXNt
         1Oow==
X-Gm-Message-State: AOAM531pwqWXsVk8vRxfzfzUE8b4LZ+pkF3QDXxdEOBl+lAQnkwHQSJR
        BSU7dz2md+g6BiNWGeiKc/2ZvGEtpSZ/1cOS1g==
X-Google-Smtp-Source: ABdhPJzBldoABAd0mQx4RYFCK9R0TKe0g7vuNfqtxhDSFNs9+wMSula/2OxLKG+UrVNXt59GkbHp7qUHRfGcOnH+fvY=
X-Received: by 2002:a92:db0b:: with SMTP id b11mr2935465iln.275.1631777640713;
 Thu, 16 Sep 2021 00:34:00 -0700 (PDT)
MIME-Version: 1.0
From:   Jinmeng Zhou <jjjinmeng.zhou@gmail.com>
Date:   Thu, 16 Sep 2021 15:33:49 +0800
Message-ID: <CAA-qYXjxht4+GhTjNb0xmr4dLQYDVpDbO1R_FDcWtnsrQC=VNQ@mail.gmail.com>
Subject: A missing check bug in cgroup1_reconfigure()
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     shenwenbosmile@gmail.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dear maintainers,
hi, our team has found a missing check bug on Linux kernel v5.10.7
using static analysis.
There is a checking path where cgroup1_get_tree() calls cgroup1_root_to_use=
()
to mount cgroup_root after checking capability.
However, another no-checking path exists, cgroup1_reconfigure() calls
trace_cgroup_remount()
to remount without checking capability.
We think there is a missing check bug before mounting cgroup_root in
cgroup1_reconfigure().

Specifically, cgroup1_get_tree() uses ns_capable(ctx->ns->user_ns,
CAP_SYS_ADMIN) to check
the permission before calling the critical function
cgroup1_root_to_use() to mount.

1. // check ns_capable() ////////////////////////////
2. int cgroup1_get_tree(struct fs_context *fc)
3. {
4.  struct cgroup_fs_context *ctx =3D cgroup_fc2context(fc);
5.  int ret;
6.  /* Check if the caller has permission to mount. */
7.  if (!ns_capable(ctx->ns->user_ns, CAP_SYS_ADMIN))
8.    return -EPERM;
9.  cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
10. ret =3D cgroup1_root_to_use(fc);
11. ...
12. }

trace_cgroup_remount() is called to remount cgroup_root in
cgroup1_reconfigure().
However, it lacks the check.
1. int cgroup1_reconfigure(struct fs_context *fc)
2. {
3.  struct cgroup_fs_context *ctx =3D cgroup_fc2context(fc);
4.  struct kernfs_root *kf_root =3D kernfs_root_from_sb(fc->root->d_sb);
5.  struct cgroup_root *root =3D cgroup_root_from_kf(kf_root);
6.  int ret =3D 0;
7.  u16 added_mask, removed_mask;
8.  ...
9.  trace_cgroup_remount(root);
10. ...
11. }

We find cgroup1_reconfigure() is only used in a variable initialization.
Function cgroup1_get_tree() is also used in this initialization.
Both functions are indirectly called which is hard to trace.
We reasonably consider that the two functions can be equally reached
by the user,
therefore, there is a missing check bug.
1. static const struct fs_context_operations cgroup1_fs_context_ops =3D {
2. =E2=80=A6
3.  .get_tree =3D cgroup1_get_tree,
4.  .reconfigure =3D cgroup1_reconfigure,
5. };


Thanks!


Best regards,
Jinmeng Zhou
