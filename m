Return-Path: <cgroups+bounces-13964-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yERKCLTUkmlMywEAu9opvQ
	(envelope-from <cgroups+bounces-13964-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 09:26:28 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F590141885
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 09:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27CDA300CE75
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 08:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041A42DCBFD;
	Mon, 16 Feb 2026 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wk1808iE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820CE2DF134
	for <cgroups@vger.kernel.org>; Mon, 16 Feb 2026 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771230367; cv=none; b=qYqZcQgbsLqK6PiBDIm9UYWVQK4Zol49CS2Yl3FEeOtFAbS3+EjxbYRdKaVzNevF0DeoNxalnf7pUwnaxnJAFk/JYxCicG4nUEC4jO4iaDuBWhR/IJBjG69lKDcsl/nBK8gBH1d4eVh+odEIjCU+Dbdry9GdkXqG/tss8kROt1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771230367; c=relaxed/simple;
	bh=lVYcW124xXUpGqImemRfOTuqz9/8KIKwr6TZK67q7ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwfR/1W7dPPVRzAQR6ml9XMVtNtPdO7VnjcGb3AsNB9+1zc2NZdAJy3CbifR++ZqliFvS459xEUl2ZgfY/GuxTm1Ck7pVBzkcHDrB2jxp+JBHW33jAnZoziBkQdYLhpdMfWlcID1aB9gLVKfMtQGX+soNtLqWFjyDvG/Of4l/Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wk1808iE; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48371bb515eso31691865e9.1
        for <cgroups@vger.kernel.org>; Mon, 16 Feb 2026 00:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771230365; x=1771835165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xb3Y5mpUx/KX/i4KodCYFSkUEnbxPYW1NpgmoLibx/U=;
        b=Wk1808iEY47Igz+FN0gG9ttvtUP29bgVI8DKINBj9fwDauyN0DnxBIpiUUp5Hs435g
         /j9lUqzcnVZehsXAA9c+NECUDnI2rST4rz07vFt0biGrBTITUTnU9ZkRIOjQHdLFEY15
         Mjclt0uXbXbYDoN5oqWhnH7atps7IuzMOzi9JEOKZA4f1gd/5T/LoH/utPkHDb0jOd2b
         LecL+egjWtO21y4aNqYz2wCHuwXThWe5TeQ3MEo6+UE+TVRfaYpbxCuSjtaqR23uJ/Dz
         rnOwdq4C5GDA/JYps0YhU9UM8dxIcKnd/EZD/YRrNSuXN2eXpFFoRsqlI4HxOp7HQSau
         O1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771230365; x=1771835165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xb3Y5mpUx/KX/i4KodCYFSkUEnbxPYW1NpgmoLibx/U=;
        b=IrT8j02pyzgImB6rA0mxcKg2f1huK/YydbTuKu1lf9Dne6AOjrI6eoecaIt7C9G4kE
         oCIm574x3B6KFiB8jPaMjDOYzkRLg6zVjZvD8r5vJktS0suxdvBFuKj5oOUL/sQW08dT
         s722MNfKIMZBgEti7bxy7lEJe2KaQtPoVxlUU8yW+bu3nha7StthMWTd/QKEJxSaAVHz
         Hp2WK7H4SAcrYmhSrTO7p5GSC/ugaY0l5XD1jmHaJAk7VbYoKf3OjnlSzK1qNboPNQm5
         AFNuCbFJJfvGiNXcwIoHzrfTUst77hHsV8OCVtA6pgMQtG40S1jRwXsw/mnQR5H7Z382
         q2xg==
X-Forwarded-Encrypted: i=1; AJvYcCV/ID8cVCneM4s2ha7ViUUpA4riSbVxPg3okh4GUGJU7r88tF1acoQ3c4wiEA6esLtXWkkN5agZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxVz8M2iQW2/ViviV5oN8EAnN+QA3f4iMeB80xr9mrrcMSe30sa
	4FPmXbmaN8S1WboZ1z96ze33Kt5oPjrdTT7XWnkqCiyWP+NOYXZLg+Rnk4qwhQybgds=
X-Gm-Gg: AZuq6aL+TMAzwqowHyEglDrADWJbGzZjVkv8bj7wjZD3h4GzkgM0voeEQ9bF+d8cSw/
	tPDHYhcMrX56nMthrxjHnsjULIbyEW2PlQGexRI/aPRrhuknehCY/iOHFhpPpWGrtGUDwP4hv3l
	FxL8tQT94GUhFOpZyq1eraLkz4G5f8J/0AMDV031l1Zr0ywahFox5SHMBLN7Qom2O+DemcEzAwF
	/UVC3p2aoRSWrMKtlMuI6dFkax1mfmH+9Kok5yR0DgC7GuSPV0foj5fckI5GKdYwRaDHxsZxCJB
	mO+ZiP3zlSvBkKrnFY5g9y6XPqvxBnyWkcbxZxzchb+F4ztAJZGqudDFZnXY0J3XBs1MX7lYUTN
	txqClNQl6g61tnv47dx76kOi3/n+KoZXVCCYlWd+v9Z9OS3/qbvCHvh3+M8JZCDkRAtNDlSN4ul
	O/DG6yZbkMFPOoIq8U2kwEXj2u9bCmQVSq0Hx1
X-Received: by 2002:a05:600c:c170:b0:480:4a90:1afe with SMTP id 5b1f17b1804b1-48373a78d47mr149302415e9.34.1771230364694;
        Mon, 16 Feb 2026 00:26:04 -0800 (PST)
Received: from localhost (109-81-87-131.rct.o2.cz. [109.81.87.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a337dfsm81435315e9.19.2026.02.16.00.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 00:26:04 -0800 (PST)
Date: Mon, 16 Feb 2026 09:26:03 +0100
From: Michal Hocko <mhocko@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
	axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
	david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
	jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
	rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	surenb@google.com, virtualization@lists.linux.dev, vbabka@suse.cz,
	weixugc@google.com, xuanzhuo@linux.alibaba.com,
	ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
	kernel-team@meta.com
Subject: Re: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
Message-ID: <aZLUm95Y-dKkdBWI@tiehlicka>
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com>
 <aY2BcIHIARSwwQpo@tiehlicka>
 <eca7a8f9-173d-4cb0-93b3-df082b8d0c08@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eca7a8f9-173d-4cb0-93b3-df082b8d0c08@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13964-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kvack.org,nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,suse.cz,linux.alibaba.com,meta.com];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 7F590141885
X-Rspamd-Action: no action

On Thu 12-02-26 13:22:56, JP Kobryn wrote:
> On 2/11/26 11:29 PM, Michal Hocko wrote:
> > On Wed 11-02-26 20:51:08, JP Kobryn wrote:
> > > It would be useful to see a breakdown of allocations to understand which
> > > NUMA policies are driving them. For example, when investigating memory
> > > pressure, having policy-specific counts could show that allocations were
> > > bound to the affected node (via MPOL_BIND).
> > > 
> > > Add per-policy page allocation counters as new node stat items. These
> > > counters can provide correlation between a mempolicy and pressure on a
> > > given node.
> > 
> > Could you be more specific how exactly do you plan to use those
> > counters?
> 
> Yes. Patch 2 allows us to find which nodes are undergoing reclaim. Once
> we identify the affected node(s), the new mpol counters (this patch)
> allow us correlate the pressure to the mempolicy driving it.

I would appreciate somehow more specificity. You are adding counters
that are not really easy to drop once they are in. Sure we have
precedence of dropping some counters in the past so this is not as hard
as usual userspace APIs but still...

How exactly do you tolerate mempolicy allocations to specific nodes?
While MPOL_MBIND is quite straightforward others are less so.
-- 
Michal Hocko
SUSE Labs

