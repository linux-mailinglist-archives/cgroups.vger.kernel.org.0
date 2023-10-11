Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3A17C57CE
	for <lists+cgroups@lfdr.de>; Wed, 11 Oct 2023 17:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjJKPLV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Oct 2023 11:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjJKPLU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Oct 2023 11:11:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9A0AF
        for <cgroups@vger.kernel.org>; Wed, 11 Oct 2023 08:11:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9c145bb5bso161195ad.1
        for <cgroups@vger.kernel.org>; Wed, 11 Oct 2023 08:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697037078; x=1697641878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ysq39f+RxeDX0QxC2g4cZxAZIgMWhz132Glg6XcD8zQ=;
        b=1+XlyBtvlLoKGwmtBONU4oGiB3nbY3ZkaSIc6DrJsXlozmjgauAuKB9/VfZmP279Lf
         NmAjve4A+YsfP9P3x6Z6zeayx0TRWAMEiaItASA9rStC442xFjhlEFSlcXibhZDgTY7T
         FUEiml5OhDE8rX2RWqCE45O5FWG3eOaSkyOm5f7Giay9w+DbxxmE+1vXOBvUzBHFIEnd
         s3c0Xm7LqupOXFobMF8SKpdwEmSdVavv80w1LSncTxuvq7kzNvI+HzEg9eINhGIm7Ncp
         6oUJhPvc2JfvOc0jKPLovblnh88XWRVQFsAnVov4ip9ZDoiZtU7TGrKR9qfitlGaGeaD
         FEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697037078; x=1697641878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ysq39f+RxeDX0QxC2g4cZxAZIgMWhz132Glg6XcD8zQ=;
        b=JNLm2secs7VkO/mLRIdyqU6ktOIlw4ik0B0nI9raq2hZNUMOFd5n+Xv6ZCPXTO+D95
         qsQ7GSJKK61xB+XXmT6oJ+TdfxMVCEhQ925YYRavyylgcia97qk9AdzOEndHy5RasCne
         rJncJ/SEnrBhgoXETdKp6RctXoCQH9Tly23niZk80AG21z9KKKY4e6SrhZPWEAfJDmnK
         t6FN+CgoaYnzJvq94cy7uGs+bH8GA4CyFPf6mD9NZLoig/HECK/yvk3HuzEyZ8o8Tlcg
         XZLMDLyXblBleuEjNFQJRpx1/aezlAvX57qI6O7P84Ok/NcnMN0WcKRKYwcy8Lnql0Zw
         KyeQ==
X-Gm-Message-State: AOJu0YxbLufvCqEHcdKWnc/xTPaPN58Rv7rnTP/oK4RVnbmXFKej/gCz
        3XKi6Sc7yD7bsXWL17oFrBNIzX3wQnfWJrLVPFDPJA==
X-Google-Smtp-Source: AGHT+IE+7M622fVnoDLgJHtsFi0t4ael64syMh6Fu5jaC4A4ui2zUGTpZ++FeUNQsKe7If7WQC+EoGIipP1ya8Ox4w0=
X-Received: by 2002:a17:902:c641:b0:1c7:47ca:f075 with SMTP id
 s1-20020a170902c64100b001c747caf075mr197756pls.15.1697037078136; Wed, 11 Oct
 2023 08:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001db97f06075bf98b@google.com> <20231010142050.GA128254@cmpxchg.org>
In-Reply-To: <20231010142050.GA128254@cmpxchg.org>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 11 Oct 2023 17:11:06 +0200
Message-ID: <CANp29Y75YE2Z6HDJ=OJ0RhPjniEzja6jx9QQ0PGrtqLkpjoUww@mail.gmail.com>
Subject: Re: [syzbot] [cgroups?] [mm?] WARNING in mem_cgroup_migrate
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     syzbot <syzbot+831ba898b5db8d5617ea@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
        roman.gushchin@linux.dev, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 10, 2023 at 4:20=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> This is the earlier version of the hugetlb cgroup accounting patches
> that trigger on an uncharged hugetlbfs:
>
>   7547          /*
>   7548           * Note that it is normal to see !memcg for a hugetlb fol=
io.
>   7549           * It could have been allocated when memory_hugetlb_accou=
nting was not
>   7550           * selected, for e.g.
>   7551           */
>   7552          VM_WARN_ON_ONCE_FOLIO(!memcg, old);
>
> It's been fixed in the revision that's in the latest next release:
>
>   7539          /*
>   7540           * Note that it is normal to see !memcg for a hugetlb fol=
io.
>   7541           * For e.g, itt could have been allocated when memory_hug=
etlb_accounting
>   7542           * was not selected.
>   7543           */
>   7544          VM_WARN_ON_ONCE_FOLIO(!folio_test_hugetlb(old) && !memcg,=
 old);
>   7545          if (!memcg)
>   7546                  return;
>
> > Modules linked in:
> > CPU: 1 PID: 5208 Comm: syz-executor.1 Not tainted 6.6.0-rc4-next-202310=
05-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 09/06/2023
> > RIP: 0010:mem_cgroup_migrate+0x2fa/0x390 mm/memcontrol.c:7552
> > Code: f7 ff e9 36 ff ff ff 80 3d 84 b2 d1 0c 00 0f 85 54 ff ff ff 48 c7=
 c6 a0 9e 9b 8a 48 89 ef e8 0d 5c df ff c6 05 68 b2 d1 0c 01 <0f> 0b e9 37 =
ff ff ff 48 c7 c6 e0 9a 9b 8a 48 89 df e8 f0 5b df ff
> > RSP: 0018:ffffc90004b2fa38 EFLAGS: 00010246
> > RAX: 0000000000040000 RBX: ffffea0005338000 RCX: ffffc90005439000
> > RDX: 0000000000040000 RSI: ffffffff81e76463 RDI: ffffffff8ae96da0
> > RBP: ffffea0001d98000 R08: 0000000000000000 R09: fffffbfff1d9db9a
> > R10: ffffffff8ecedcd7 R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000200 R14: 0000000000000000 R15: ffffea0001d98018
> > FS:  00007fc15e89d6c0(0000) GS:ffff8880b9900000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000001b31820000 CR3: 000000007f5e1000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  hugetlbfs_migrate_folio fs/hugetlbfs/inode.c:1066 [inline]
> >  hugetlbfs_migrate_folio+0xd0/0x120 fs/hugetlbfs/inode.c:1049
> >  move_to_new_folio+0x183/0x690 mm/migrate.c:966
> >  unmap_and_move_huge_page mm/migrate.c:1428 [inline]
> >  migrate_hugetlbs mm/migrate.c:1546 [inline]
> >  migrate_pages+0x16ac/0x27c0 mm/migrate.c:1900
> >  migrate_to_node mm/mempolicy.c:1072 [inline]
> >  do_migrate_pages+0x43e/0x690 mm/mempolicy.c:1171
> >  kernel_migrate_pages+0x59b/0x780 mm/mempolicy.c:1682
> >  __do_sys_migrate_pages mm/mempolicy.c:1700 [inline]
> >  __se_sys_migrate_pages mm/mempolicy.c:1696 [inline]
> >  __x64_sys_migrate_pages+0x96/0x100 mm/mempolicy.c:1696
> >  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> >  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:81
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7fc15da7cae9
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fc15e89d0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000100
> > RAX: ffffffffffffffda RBX: 00007fc15db9bf80 RCX: 00007fc15da7cae9
> > RDX: 0000000020000340 RSI: 0000000000000080 RDI: 0000000000000000
> > RBP: 00007fc15dac847a R08: 0000000000000000 R09: 0000000000000000
> > R10: 00000000200003c0 R11: 0000000000000246 R12: 0000000000000000
> > R13: 000000000000000b R14: 00007fc15db9bf80 R15: 00007ffd87d7c058
> >  </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the bug is already fixed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
>
> #syz fix: next-20231010
>

Thanks for sharing the info and updating the issue!

If there's no fixing commit (the faulty series is dropped or
replaced), it's better to just invalidate the report:

#syz invalid

Otherwise, as in this case, syzbot would start looking for the
"next-20231010" commit (and won't find it because it's a tag) and,
after some time, start complaining that no such commit is reachable
from any of the master branches of the tested trees.

--=20
Aleksandr
