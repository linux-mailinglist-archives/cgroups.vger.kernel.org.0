Return-Path: <cgroups+bounces-14437-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MC1DE2QoGkokwQAu9opvQ
	(envelope-from <cgroups+bounces-14437-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 19:26:21 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 853AE1AD943
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 19:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE17B341E671
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 17:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA74368977;
	Thu, 26 Feb 2026 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7k4gjcp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3787368953
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772126029; cv=none; b=fOsj3ns82MReAM0yi2qY4ksOLVC59IMNEAvQ3gDJB8E7ojJYOekn566lofx7KRq21jSRz1HbDFdBAKcKpIW9TYKpStReuFq3CmGXDLk/SVpjVYgV3ALhTxTa18Bc8eXhW6aDTjbK2cdgaLarmYrWq5cDeMpynIcRFuX548tWC5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772126029; c=relaxed/simple;
	bh=euWQYI6VTPnWxe/R+ZB/rm5QUfnQgxdguDrbNCz0+DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehLU2VjXdf6FOTHxLyF7Xkk691fxpM2wMP38tDoGv05r0TGEqVlKDDvcMJTsQfgZshHUAd5itEKUZPRC6VcTX228aD1RbRbMBILKkPDrfy8r6JjQcDN7PzoEQYO63LrJAEyZz7JLdDfdAHhk5PComRLWuH6H9+xiewHfCeseP5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7k4gjcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D1CC2BCB1
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 17:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772126028;
	bh=euWQYI6VTPnWxe/R+ZB/rm5QUfnQgxdguDrbNCz0+DI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K7k4gjcpwjNwnZ2fgQsF8UVFuRsxg+wJOyVRtwctubPWHIeBA7MXw840pLoqjLJhp
	 fhHn+v2aMxmRZUnGCuxC5gvLvXyBIwK/0KoKFe6x3ncGF+Y4JFB/i56JIL7Kcd/v1d
	 D+FHEatHll/2g8R9O4jOwa3BLd6MFVCMCfjqAqHaxmHjv8wrhOIphpyWvpxKKz4+5B
	 heUAe5gkd7FiKsgGzg2WrpLAbrD+tmi9h518wBWlePniR7uDZINzZRKqa32ciL9C97
	 ZoGlVSgd3fAVz5EDaye23HFGUWRYwCOwsG1J+iGppF0FAWu9m6Y2XCTQGvfw4yidBV
	 gwLqBNZIlBnSQ==
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899a98c2421so19661176d6.3
        for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 09:13:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXCG/2v07afwPJOo3ach5Qly7nHQeqWyzF9ymRc+dR78EwRJNGyPukr1Fx9GoSoIWbX2iqTNVra@vger.kernel.org
X-Gm-Message-State: AOJu0YyrOLhxwgoZ7zNg5YwmDE7+/mmF3rOhy0T3AqPoipblvHk+k5c6
	FiQkW/HX0ROYlGMFa3baUhWaReFA7Oz3qX3OJ+S9CJLmiIGIGmlOY96ArvEwmOX+qaLkTPH/eTM
	ZC+0DWM86Lwz747epXaEpOW1a/u15J3c=
X-Received: by 2002:a05:6214:627:b0:894:6f12:af5c with SMTP id
 6a1803df08f44-899c13dd9d0mr72291106d6.24.1772126027803; Thu, 26 Feb 2026
 09:13:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772005110.git.zhengqi.arch@bytedance.com>
 <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
 <CAO9r8zOhZgrym6oSrtg7b+HmNHEfWuAzZ0i8eYhm5-OEnfFLdw@mail.gmail.com>
 <aZ-R87JfacQ2gGq1@linux.dev> <CAO9r8zPmgytmGHAbueFKXcZWY5SJaEwD3Pqk99ws4XeO2_hnKw@mail.gmail.com>
 <aaB7yYSpAaC5uInq@linux.dev>
In-Reply-To: <aaB7yYSpAaC5uInq@linux.dev>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 26 Feb 2026 09:13:35 -0800
X-Gmail-Original-Message-ID: <CAO9r8zOP-kB=8ADGAUZYnpY-rxG1TCGbQg3FxqyC7WrOu3NASg@mail.gmail.com>
X-Gm-Features: AaiRm52kMdcu5UAJBT1YFqYWZjlPJf22WLU_UA6yC-0U8iG5lX8r98zBJgwmLKM
Message-ID: <CAO9r8zOP-kB=8ADGAUZYnpY-rxG1TCGbQg3FxqyC7WrOu3NASg@mail.gmail.com>
Subject: Re: [PATCH v5 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com, 
	mhocko@suse.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
	harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, 
	apais@linux.microsoft.com, lance.yang@linux.dev, bhe@redhat.com, 
	usamaarif642@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14437-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,cmpxchg.org,google.com,suse.com,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: 853AE1AD943
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 9:03=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Feb 26, 2026 at 07:16:50AM -0800, Yosry Ahmed wrote:
> > > > Did you measure the impact of making state_local atomic on the flus=
h
> > > > path? It's a slow path but we've seen pain from it being too slow
> > > > before, because it extends the critical section of the rstat flush
> > > > lock.
> > >
> > > Qi, please measure the impact on flushing and if no impact then no ne=
ed to do
> > > anything as I don't want anymore churn in this series.
> > >
> > > >
> > > > Can we keep this non-atomic and use mod_memcg_lruvec_state() here? =
It
> > > > will update the stat on the local counter and it will be added to
> > > > state_local in the flush path when needed. We can even force anothe=
r
> > > > flush in reparent_state_local () after reparenting is completed, if=
 we
> > > > want to avoid leaving a potentially large stat update pending, as i=
t
> > > > can be missed by mem_cgroup_flush_stats_ratelimited().
> > > >
> > > > Same for reparent_memcg_state_local(), we can probably use mod_memc=
g_state()?
> > >
> > > Yosry, do you mind sending the patch you are thinking about over this=
 series?
> >
> > Honestly, I'd rather squash it into this patch if possible. It avoids
> > churn in the history (switch to atomics and back), and is arguably
> > simpler than checking for regressions in the flush path.
>
> Yup, let's squash it into the original patch. Please add your sign-off ta=
g.

Sure. Qi/Andrew, feel free to add these tags if you squash the diff below:

Co-developed-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>

>
> >
> > What I have in mind is the diff below (build tested only). Qi, would
> > you be able to test this? It applies directly on this patch in mm-new:
>
> Qi, please squash this diff into the patch and test. You might need to ch=
ange
> the subsequent patches. Once you are done with testing, you can post the =
diffs
> for those in reply to those patches and we will ask Andrew to squash into
> orinigal ones.

FWIW, after applying this diff, the rest of the series applies
cleanly. So I think we won't need diffs for other patches.

> The diff looks good to me though.

Thanks for taking a look!

