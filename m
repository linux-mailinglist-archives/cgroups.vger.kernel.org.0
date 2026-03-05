Return-Path: <cgroups+bounces-14619-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Io7hOOrLqGmhxQAAu9opvQ
	(envelope-from <cgroups+bounces-14619-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 01:18:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F2B20960F
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 01:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90FE53022606
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 00:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7011A9F94;
	Thu,  5 Mar 2026 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vK4xwT8o"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6B1B808
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772669925; cv=none; b=lAiEgrp56ySKIH7/QHY82aCGUaY3v+yNs1J3G6/3xw8Pvo7kKYQgecZnphgQcQVPvTvzQea9CrHKW4quev8Zweg765pul8jMpnwi6GPCHYqZakFsPv7sV7SAsnwxmczAFlLFLiNSf53mlKdCdESwlxze8tEVJxJM/LkCWk7u6a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772669925; c=relaxed/simple;
	bh=GjdElT5AcZfytgoGbVIxtcG8IOmcqOEZiw3Vz/wJrjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUTc/jmUB1yX+dR7H1YlnRLChkMU7OndfFQSSzzHXrEgeH4XNUCbuDHaujDZjIpCZ6/MSI6qP84eFqLZXq4SyVPFXp3PF54BdN5R9OdLoAQs2T6vcKLQFazpZQ5EQvBAefxFBNcTMOaMeMqxC22suUiJpmJflcdmP2p1twrRBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vK4xwT8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475F7C2BCB0
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 00:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772669925;
	bh=GjdElT5AcZfytgoGbVIxtcG8IOmcqOEZiw3Vz/wJrjA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vK4xwT8o1cx8LuEPzA+zJUkQ9D/6tKwPsqCZ/KC4dygPdMQR/sHdEEI3p6uCNFljX
	 2V06M6bgOv/iy+6wWNuGoMvMc9x/mXfSW2p5Sr1aIOZ0CF2efqQbehRhfYateWZmhT
	 qhI3BTxyG9yjuz4ZWnKBzEJJRzu2+xoBgQ720GvgBl/n6Y+wDrZjNxaC2P8+tSk07p
	 y01OogeoEw5msaLaRaOsC9tvqnv4DX9zEQwX7MY/jHPCQgMFSx0zOdS6FiLx1x/Yes
	 JS0sITlcTOLCsEXeeLE9NLhftSJ2shxcGzxP0xhOBoCBYJdvaPzAJR0D3VqKxwe5Wh
	 A2YrXwH144K0g==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-660d2e48383so3139539a12.1
        for <cgroups@vger.kernel.org>; Wed, 04 Mar 2026 16:18:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUST7BKxNjXFCBPtoRVdY3uxU0NggziwTv5keKZ6jalNcdO6yE+Q5MNz9iirHGJIRRP0MygeA2m@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ITM2tkMJdHMjmQ+6t8gQKskq129Acsguxu4K3MjgKh7Ljzm+
	Khi94rXOpkoWEevBXE5VWDa7qTZVV5pxv9bb1iyeBpvFTDDbRcxscnOb2k2yJAJNahFdr9n5smG
	+j/C+VmQleUX/hVVEBPk4DrvFyAx68j4=
X-Received: by 2002:a17:907:3da1:b0:b88:7568:26d5 with SMTP id
 a640c23a62f3a-b93f13b772amr255810066b.27.1772669923954; Wed, 04 Mar 2026
 16:18:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
 <20260228072556.31793-1-qi.zheng@linux.dev> <CAO9r8zNYFvNnz_oTu10kPBYL6=1ZewKUMRYcMmcMdSqbro_miA@mail.gmail.com>
 <de1476aa-20a3-420e-9cd7-9238efd3c85f@linux.dev> <46bgg2vwqvmex7wtk2fkvf454tqgaychb7l4odnnrx7svci5ha@vy4b4ophm763>
 <22cca07c-49e0-42e8-b937-7b1c7c51e78d@linux.dev> <vfmyb3pp2gatdrqa2uimw44pxioreo7zc373zn7buvdfzhejew@ndhaa4yl3bvh>
 <20260304140307.f51a33f77f6ddc1dfc0cf476@linux-foundation.org>
In-Reply-To: <20260304140307.f51a33f77f6ddc1dfc0cf476@linux-foundation.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 4 Mar 2026 16:18:32 -0800
X-Gmail-Original-Message-ID: <CAO9r8zP9VseSaEO6to9rcRW_TZ6E6Qk4ZQgj49g9bQOAdjgQvQ@mail.gmail.com>
X-Gm-Features: AaiRm516Oe_1QYwFsS8hjIc6T-4dgjb-_Q4aKlr8O9HklowPRK7Y8a1pQV4Wayk
Message-ID: <CAO9r8zP9VseSaEO6to9rcRW_TZ6E6Qk4ZQgj49g9bQOAdjgQvQ@mail.gmail.com>
Subject: Re: [PATCH v5 update 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com, 
	mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com, 
	ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, mkoutny@suse.com, 
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, bhe@redhat.com, usamaarif642@gmail.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Qi Zheng <zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 32F2B20960F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14619-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,cmpxchg.org,google.com,suse.com,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-foundation.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 2:03=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed, 4 Mar 2026 13:57:41 +0000 Yosry Ahmed <yosry@kernel.org> wrote:
>
> > > > What about this (untested), it should apply on top of 'mm: memcontr=
ol:
> > > > eliminate the problem of dying memory cgroup for LRU folios' in mm-=
new,
> > > > so maybe it needs to be broken down across different patches:
> > > >
> > >
> > > I applied  and tested it, so the final updated patches is as follows,
> > > If there are no problems, I will send out the official patches.
> >
> > If I am not mistaken, Andrew prefers fixups to what he already has in
> > mm-new (Andrew, please correct me if I am wrong).
>
> Yes, if the changes are reasonably small and the code has already
> undergone significant review.
>
> Although the mm-new branch is quite speculative/early so I guess this
> is less important there.
>
> Adding a sprinkle of -fix patches can be a pain all round, so nowadays
> if someone sends a replacement series I'll generate and send a
> what-you-changed-since-last-time diff.  So
>
> - we can check that the diff matches the changelogged updates
> - reviewers don't have to re-review everything
> - the author can eyeball it and think "yup, I meant to change that".
>
> I believe this series is due for quite a few updates so a full v6
> resend series would be appropriate.  I'll generate the
> how-you-changed-mm.git email from that.

Thanks for chiming in. Qi, if you send a new version, I think
separating refactoring (and moving, if needed) mod_memcg_state() and
mod_memcg_lruvec_state() into a separate patch will make things easier
to review.

