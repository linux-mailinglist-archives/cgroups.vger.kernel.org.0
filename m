Return-Path: <cgroups+bounces-14617-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLuGNLauqGmfwQAAu9opvQ
	(envelope-from <cgroups+bounces-14617-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 23:14:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF25E2085D4
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 23:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D671D30581BF
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 22:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1289A3E556A;
	Wed,  4 Mar 2026 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rlpLqS/K"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5193E51CA;
	Wed,  4 Mar 2026 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661788; cv=none; b=P47CwMNfYCGOk/AZc/ZXZKD6FBOE6/I0eHeSYqfk0CyahcvbEJ0KwW0l6DYG1Qu9ADhHjt3LYQO4rwHsDO+X3ckwa8Th19Bpzk/VcHiO5UytD30LaaOyOIjsPk7jVY5wCPLjI5VcekaqBiO76m/AdJwDdJbpfrMydgqi2xjPGUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661788; c=relaxed/simple;
	bh=QcDeX+4A0lvHQQbRg9leLOGUG35mNFYWz5fL5TVLF1Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UReHcx6aluB+F3msyf/OmEuif775EZsJte5BuxoYe6Q9ybMUITbjR6sAjdinuVdXVNpm9c/YbriRKGURo2FDaNYEKCeV8n2Kw7laNkHfMjsEG1F6S5X/fSP21Xyx0eeA+XjOyodZTZNRteOd/1VnGxM202AouKw8iLJSraYJUqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rlpLqS/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A735FC19425;
	Wed,  4 Mar 2026 22:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772661788;
	bh=QcDeX+4A0lvHQQbRg9leLOGUG35mNFYWz5fL5TVLF1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rlpLqS/Kj6XuSnENrppvplSEKrxYqPvM+aALj0ec5JjEL9u5ixAsovpcNNV7ejj0S
	 ljLr1AObex51OKKnoemq2v5AjE6O6xx8BW7Uq/Mxw9EQkmTCgKqYr0ac2XQl6ye+cM
	 GGkekwE02kT/+Xw0PJzgRoeJlHS3jhSKzvw6sAt4=
Date: Wed, 4 Mar 2026 14:03:07 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yosry Ahmed <yosry@kernel.org>
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
Subject: Re: [PATCH v5 update 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
Message-Id: <20260304140307.f51a33f77f6ddc1dfc0cf476@linux-foundation.org>
In-Reply-To: <vfmyb3pp2gatdrqa2uimw44pxioreo7zc373zn7buvdfzhejew@ndhaa4yl3bvh>
References: <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
	<20260228072556.31793-1-qi.zheng@linux.dev>
	<CAO9r8zNYFvNnz_oTu10kPBYL6=1ZewKUMRYcMmcMdSqbro_miA@mail.gmail.com>
	<de1476aa-20a3-420e-9cd7-9238efd3c85f@linux.dev>
	<46bgg2vwqvmex7wtk2fkvf454tqgaychb7l4odnnrx7svci5ha@vy4b4ophm763>
	<22cca07c-49e0-42e8-b937-7b1c7c51e78d@linux.dev>
	<vfmyb3pp2gatdrqa2uimw44pxioreo7zc373zn7buvdfzhejew@ndhaa4yl3bvh>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DF25E2085D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14617-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,cmpxchg.org,google.com,suse.com,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux-foundation.org:dkim,linux-foundation.org:mid]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 13:57:41 +0000 Yosry Ahmed <yosry@kernel.org> wrote:

> > > What about this (untested), it should apply on top of 'mm: memcontrol:
> > > eliminate the problem of dying memory cgroup for LRU folios' in mm-new,
> > > so maybe it needs to be broken down across different patches:
> > > 
> > 
> > I applied  and tested it, so the final updated patches is as follows,
> > If there are no problems, I will send out the official patches.
> 
> If I am not mistaken, Andrew prefers fixups to what he already has in
> mm-new (Andrew, please correct me if I am wrong).

Yes, if the changes are reasonably small and the code has already
undergone significant review.

Although the mm-new branch is quite speculative/early so I guess this
is less important there.

Adding a sprinkle of -fix patches can be a pain all round, so nowadays
if someone sends a replacement series I'll generate and send a
what-you-changed-since-last-time diff.  So

- we can check that the diff matches the changelogged updates
- reviewers don't have to re-review everything
- the author can eyeball it and think "yup, I meant to change that".

I believe this series is due for quite a few updates so a full v6
resend series would be appropriate.  I'll generate the
how-you-changed-mm.git email from that.


