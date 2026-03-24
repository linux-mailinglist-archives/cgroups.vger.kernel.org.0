Return-Path: <cgroups+bounces-15013-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fVnNOcUVwmn0ZQQAu9opvQ
	(envelope-from <cgroups+bounces-15013-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 05:40:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 588A83020BD
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 05:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10EB1303D70F
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 04:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB272737EB;
	Tue, 24 Mar 2026 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L48eLu0g"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A11A6832;
	Tue, 24 Mar 2026 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774327234; cv=none; b=rB3kjgWY5HAvMO2eD/WIrP5T51aBGxAIMy0LiYREotx+EHryvaH2LM043W1Hn+GcTsxfqtq3nS2mpxmsO7XqfgYTYDl/i+eP2UitaGxSHRIs8iG6tNt7yJVWQWND/LTGLir0M0B9I5RcGtFY1AZlusavQyz37TinhPWVae9QMn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774327234; c=relaxed/simple;
	bh=loPaoIv+zE5Iyk/V9kLFJDEN6F+Lpy7F7j8B74xqzKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtCOiZVTiXB8JLh7JEeZVs3qgB1acgs7jNYbgYbQJnCK4qtkjnVO90SfEVq7lwuav2YBea6kw1dlVESGkhZLDQFGN2iFIyG6OAzMD3vv2wCWxQWSGO/f0MToLYHtVp1fMiix9BVdmU3pcz/dtyYnNNlTBIFzp0LTQngyEBPbS+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L48eLu0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADAFC19424;
	Tue, 24 Mar 2026 04:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774327233;
	bh=loPaoIv+zE5Iyk/V9kLFJDEN6F+Lpy7F7j8B74xqzKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L48eLu0gsNzfLk0cW3B98uy4zM9DenEhROjLupQYl9xFPWiTdiLoUSngK53UkWjyS
	 Y3B0ANxOVzenZ2y152NVmyWSE0FWD1GS/5ZYaBve8kNsU+/UTxnxKiBP+WLuoXJ8mN
	 Gzupv8u57JfHU4irjn/z6tdRQnILxm3TU1U38z8aHl9LxmA7AOkpKA3K8NvxfGq5q2
	 Azp4IbwudUo2+aKucZQyreoTFFAIb0CIXNiBV4ZRpz6z3PXt0Z7fNRm4sO2Hbdu8cI
	 eLLMOTyem2zEHLGB3OzO4GWDSr2+z8iY/sQpqFFfcEeO2Ud2x6kxrQKVNbxLg7US7W
	 SoZSWHFPVHbzg==
Date: Tue, 24 Mar 2026 13:40:31 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
	ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, bhe@redhat.com,
	usamaarif642@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v6 30/33] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
Message-ID: <acIVv3Pr9FWwYuwB@hyeyoo>
References: <cover.1772711148.git.zhengqi.arch@bytedance.com>
 <e862995c45a7101a541284b6ebee5e5c32c89066.1772711148.git.zhengqi.arch@bytedance.com>
 <acDxaEgnqPI-Z4be@hyeyoo>
 <2d39ea5e-fd69-4acf-8518-a504f5f7a838@linux.dev>
 <acExNWaaKdhrBH-J@hyeyoo>
 <c913ce46-bc83-4d36-b1b0-a51b12e515e9@linux.dev>
 <acINdWKdH_b5LdhH@hyeyoo>
 <138d9363-ab0c-4f5c-bedc-b326f5aaee91@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <138d9363-ab0c-4f5c-bedc-b326f5aaee91@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15013-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 588A83020BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 12:25:16PM +0800, Qi Zheng wrote:
> On 3/24/26 12:05 PM, Harry Yoo (Oracle) wrote:
> > On Tue, Mar 24, 2026 at 10:54:48AM +0800, Qi Zheng wrote:
> > > On 3/23/26 8:25 PM, Harry Yoo (Oracle) wrote:
> > > > On Mon, Mar 23, 2026 at 05:47:27PM +0800, Qi Zheng wrote:
> > >
> > > so I prefer to add a cleanup patchset to
> > > avoid interfering with the merge of this patchset.
> > 
> > but it's a little bit more than a cleanup, no?
> > 
> > I'd say without the followup, this patchset introduces a very subtle
> > (likely nobody would notice) functional regression visible on memcgs
> > with billions of pages.
> 
> Right.
> 
> > > Otherwise, sending v7 might be more appropriate.
> > I think it should be sent either as v7 or as part of v7.1-rcX.
> > (Whichever way Andrew prefers)
> 
> OK, In any case I will first send out the cleanup/fix patchset for
> everyone to review.

Sounds great, thanks!

-- 
Cheers,
Harry / Hyeonggon

