Return-Path: <cgroups+bounces-14702-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0isGMRTMrWkm7gEAu9opvQ
	(envelope-from <cgroups+bounces-14702-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 08 Mar 2026 20:20:52 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BBC231DE6
	for <lists+cgroups@lfdr.de>; Sun, 08 Mar 2026 20:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FA3A3008C83
	for <lists+cgroups@lfdr.de>; Sun,  8 Mar 2026 19:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB493290A5;
	Sun,  8 Mar 2026 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tUxEmRqS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4613129C325
	for <cgroups@vger.kernel.org>; Sun,  8 Mar 2026 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772997644; cv=none; b=Y2L3Id9dAZRVE6HRBOU2Bl7JJSVH7B0Pw8tY7buFTcSR4w5hJnoSIDBCi9+EBDEizJo5dHvUffoRqoM3lmdzRrqjRULUpuwCCju9lYhW4J1NXwzyjGYuYpw6YhkZq1U7KhXS8i8um+XoQibG+514JS/O1KbluYJ3p7h/4dHi7Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772997644; c=relaxed/simple;
	bh=mIM/dD2oEQvrrW6yGLWQSr0OZLs3LodBecK8xi2Eutc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q07pm14EUDPiEUMbSRdL/InfhfCWO38mUvcmLQIXCqmefObJ4dE9donquZ8Y7m4nb9WNuaRsRDE3iSUtQ7z47jMjOYtuFAOiGcHaN9KFPQu3EVDh5TnAqwDyGRjgvGXAmzYVJ35kWh1uj+xqG/taMoKDmkEF1QLINQnj9/PuAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tUxEmRqS; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-509149ab7d7so5309621cf.2
        for <cgroups@vger.kernel.org>; Sun, 08 Mar 2026 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772997642; x=1773602442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6kmBzNS/25cHmBEwOEgUDbKXqaLe2GkCkxgRM0uJ1o=;
        b=tUxEmRqSZKVTRv+08/AlTNSjMneUGVScEGTY61CWnPlNjqLuETNP2X5pP29AHY+MUM
         ZBk3Xi+cEx/MvevV25r9K7ZoZYCc+2tbyZEvOTQVuAgRoo7KmkVznsvKKdljkeZx8IrQ
         TDpAQnMRN0fkk8u3DdLAiORf1x1sGvdaXefhCLigCbKItRoTMGKbnVFOu9Ai471ALnM5
         iFdvr9wxbejk5Z+KvLaGRGhCY3YAXHMWrZLNHP88frIZdvDpxZopO9wk24ib6gpsMkCk
         Wucmy/gf0x9ybwe9BHQxiVAMu1d0v6mZ+BwN1+x9M8+PEmo3b71HF9IQukHAoncn2O6H
         yAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772997642; x=1773602442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6kmBzNS/25cHmBEwOEgUDbKXqaLe2GkCkxgRM0uJ1o=;
        b=Wls5TieNoBsj2tp66jB5ix1i+sEglut5E+px181CY7q/W0gNXFvDOv/EKri5OBTgT4
         qO6+EBpTsS5R1pTcjXxB9sox0GYHgY/NFZLCXc2qJQjwbWDI1HXj5sJropdYyTQdqUNn
         4YO9A6or9CD22tEdfF/2DyuGd7IMQ6af01WUGYaAv834q0teO+pVDcfO0KIdMVta0/RO
         C5WQSm+XvrfPF4aAreN02BbqdcxlRUuVs0nlpoGdWMS052B4bDOOe37G6XcGftTEf1RG
         PhKORqZ5j48xdv/Tjd84DahVYK2jtlYE4cpzVFGzdIP/UYaWCrVn5TNp8jFxiSkWVkPP
         /aRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrmJvs0GhimQRMbd4t+h8geWIC1+nnFinQvkrN8t+u6sIeu5JECcesrnpwvrlIsa9C6Y+63ReX@vger.kernel.org
X-Gm-Message-State: AOJu0YyXjTFTbIBqRuIC2Tr0JlZk1MYTii9GTEm47phGRw7Vxlg58h1a
	fSoZP7G9Xh53P8KQ3AIbgXqxaOnUoCsvd9Wj8GiiUYpseDCfjDfGKMw0XlfeV98okww=
X-Gm-Gg: ATEYQzxmrwTpGmbe1mYe1WkSD3cqcrxw/hyfw9FQ2bHWDZyj4uaMkkqg5CUFlQRDv5+
	d6pFiWZ4erNjfoprJvzK0jEA0XaWAQjwlDXOJpwpQB6jjUc6OzMZ6k8ITkUQ15t6vEfVt0I27bF
	Irju1/XvPXO/jMLOO2f/JxHCwNTPmn6E1v/r2XT9pOZsYfXfKk5ekwfy9BjDuVH978EZwGeb5qJ
	STK9ZvYJtWgKQmxA9lFfVsjCNmGbuJaPjQjxHQIPBmpde5ydb6/i6OdO3XLmKReUO7ztun4B0RM
	4WArMcNRSOmylvfya2PELmP3I0NKMuhWu2dVlKUhIytKjFPIaNq638hcZtR6A94OxmlszuqBcJa
	GQuzan/s5oPHcsETwwxTQRU5Nuoi2+mulaa4J1s2u9451d78vH0H1s4JrKsqdIoSw5u/BuPrhdl
	NsmMhbMDAc5qrHwRw4m6mBAH6qaveUFyAsqR86eB5OGTxtB7nmIArdVVXrZQh1jJmkB7ZsKsLPF
	KLB1/9mpw==
X-Received: by 2002:ac8:5fd0:0:b0:4ee:1b0e:861d with SMTP id d75a77b69052e-508f46fafd3mr130582111cf.26.1772997642178;
        Sun, 08 Mar 2026 12:20:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-509101c6a55sm19141431cf.23.2026.03.08.12.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 12:20:41 -0700 (PDT)
Date: Sun, 8 Mar 2026 15:20:38 -0400
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>, linux-mm@kvack.org,
	akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
	apopple@nvidia.com, axelrasmussen@google.com, byungchul@sk.com,
	cgroups@vger.kernel.org, david@kernel.org, eperezma@redhat.com,
	jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
	rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	surenb@google.com, virtualization@lists.linux.dev,
	weixugc@google.com, xuanzhuo@linux.alibaba.com, yuanchu@google.com,
	ziy@nvidia.com, kernel-team@meta.com
Subject: Re: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
Message-ID: <aa3MBp0JhUN6zE8i@gourry-fedora-PF4VCD3F>
References: <20260307045520.247998-1-jp.kobryn@linux.dev>
 <87seabu8np.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87seabu8np.fsf@DESKTOP-5N7EMDA>
X-Rspamd-Queue-Id: B9BBC231DE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14702-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[linux.dev,kvack.org,linux-foundation.org,suse.com,suse.cz,nvidia.com,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,cmpxchg.org,gmail.com,oracle.com,intel.com,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,gourry.net:dkim,linux.dev:email]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 08:27:22PM +0800, Huang, Ying wrote:
> "JP Kobryn (Meta)" <jp.kobryn@linux.dev> writes:
> 
> >
> >   hit
> >     - for BIND and PREFERRED_MANY, allocation succeeded on node in nodemask
> >     - for other policies, allocation succeeded on intended node
> >     - counted on the node of the allocation
> >   miss
> >     - allocation intended for other node, but happened on this one
> >     - counted on other node
> >   foreign
> >     - allocation intended on this node, but happened on other node
> >     - counted on this node
> >
> > Counters are exposed per-memcg, per-node in memory.numa_stat and globally
> > in /proc/vmstat.
> 
> IMHO, it may be better to describe your workflow as an example to use
> the newly added statistics.  That can describe why we need them.  For
> example, what you have described in
> 
> https://lore.kernel.org/linux-mm/9ae80317-f005-474c-9da1-95462138f3c6@gmail.com/
> 
> > 1) Pressure/OOMs reported while system-wide memory is free.
> > 2) Check per-node pgscan/pgsteal stats (provided by patch 2) to narrow
> > down node(s) under pressure. They become available in
> > /sys/devices/system/node/nodeN/vmstat.
> > 3) Check per-policy allocation counters (this patch) on that node to
> > find what policy was driving it. Same readout at nodeN/vmstat.
> > 4) Now use /proc/*/numa_maps to identify tasks using the policy.
> 
> One question.  If we have to search /proc/*/numa_maps, why can't we
> find all necessary information via /proc/*/numa_maps?  For example,
> which VMA uses the most pages on the node?  Which policy is used in the
> VMA? ...
> 

I am a little confused by this too - consider:

7f85dca86000 interleave=0,1 file=[...] mapped=14 mapmax=5 N0=3 N1=10 ...

Is n0=3 and N1=10 because we did those allocations according to the
policy but got fallbacks, or is it that way because we did 7/7 and
then things got migrated due to pressure?

Do these counters let you capture that, or does it just make the numbers
even more meaningless?

The page allocator will happily fallback to other nodes - even when a
mempolicy is present - because mempolicy is more of a suggestion rather
than a rule (unlike cpusets).  So I'd like to understand how these
counters are intended to be used a little better.

~Gregory

