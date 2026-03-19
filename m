Return-Path: <cgroups+bounces-14913-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KNGLGILvGkArgIAu9opvQ
	(envelope-from <cgroups+bounces-14913-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 15:42:42 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4DD2CD10F
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 15:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E262304CB40
	for <lists+cgroups@lfdr.de>; Thu, 19 Mar 2026 14:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408D53A6EEC;
	Thu, 19 Mar 2026 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="twd9D5QT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593643803DC
	for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930603; cv=none; b=AY2QhIVwjO6G+LL++SnyboGT2Meq/FArNzb8pvTt63zV9HfARgX7Qgq44ZmElZTneQGe8rdBUzTLsMHeN2hTHlD1Xak9nIv7U1/3sDSTkOe911gDIvNSynCm+vcLIqpUhBU9tFAyW9FnyLqyxRbSLsL5rp0a7cUPhVXa4RP0J4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930603; c=relaxed/simple;
	bh=BArAqxuNOMZmZ3DFzVkEiSDUW/6K7+Jdphve/CIcCPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYCmg7rJcPO+C7HBjp78crU9OQG1hkekZLtHgN/uGppcWLEzmWuE5rVCRPttUNJ5qCfYqg+1aPTlbxD2W7raUfSqsbnPM1940PSi6SbGFQr9DzMNJn/kNs2LBMzapnPpBPGw1zV/9ZEcHAHhmAPFdNQHcjfkbtQ1pXsRzgxtNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=twd9D5QT; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c70b5594f4so119859885a.1
        for <cgroups@vger.kernel.org>; Thu, 19 Mar 2026 07:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1773930601; x=1774535401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZ62zRGDMh84ev+ADivtxhXkIe87cWoaQL4WKudvzqg=;
        b=twd9D5QTV+/09D1m8dWBXwC+k4zz/klk9ygEPnE7kaQ3jMDwY2JDJX7QOlF/Y2tBsS
         P8C7lf+4F2tdOenzTlWmc3kH5GhHdB0iLZzybt8SROcnrmfTdGWvu5ID5HvwLUCujeCG
         6a60XL3y6R+skrRmRzesHu9ui+3wbNnmBgJqmnZ2eQIiOPc0cxiXUbiY5TZIiyUKo1zh
         PtEtQIM9wBpfBlJtCy/or1Uw8buUZzVxLcWikstswAax3uE5bgBr6N7rxWiJjLkSuxFY
         C9mtP46Hr8W6I8ZnK/4AWpB5+Jm/DVJHRmJlvDF3V1AFlxVmCQw+YDdN2zg1I7DL273W
         DyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773930601; x=1774535401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ62zRGDMh84ev+ADivtxhXkIe87cWoaQL4WKudvzqg=;
        b=HvEFuiYT29jDLxipLaAw5qEI9P7+qOO8X8Zg0CgvPJNFxpuCXaGFFOrUutE0LOiMfX
         YDpvlh127t4Nji4Cyi8xyCK2mN2muCKSuBXv+WPOs7yUhcy0Ho+amDehd3aEW9dEeaje
         adPL1v3b46Ov3ZtKBRYcidx6NCHEh0zVltuu9Db2YwT+IevgqMTl4uB2zxVtJWCy2jmQ
         D40b4Dpq7CSI5GOkKoX4Xvu3IPcASiIebMN9X/hgtR2zXmN/4hzQPVJ0UH2tdXTXJDo+
         jGpY0+TpTx/LIf0TJL2Wto/Az97y6ppm1fQKj2YA+eQEiBMLVIei2yrAa0M4/SL3INfd
         mGKA==
X-Forwarded-Encrypted: i=1; AJvYcCWV9Lh0N0YaBLz4IAIXSY2tj8TU+xr5c8PTC5jdl0liRPiO86v42WMKnyw7Pr82yWm9xGLzNWW9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/aoFwpOFkPV7fWeOCBeFWnXK+E9qm3uyY3cLEnh/8vt2rkO+J
	FSvHe1+5FQIpEKhqS6bKniUP3jz8MGFDSSoPzTqjenspCr1PduD+JUk5N9K/M796/78=
X-Gm-Gg: ATEYQzzAE5kIZnsS3+0BEQaRw3HpP4iZgsYHwh13D9QZZDWwW08BQ1sOHp6hjYutFid
	P2mtit1FYKKk9c8GEwoRhJb5fBL0CGPAZ3dveDNMpgpwyl8gOolnCg8Ub1KCeic6kMjf4/bOZmY
	F96zgFnAXBpAN4Am/WTPRzuGz9LHomZsN2iaCD3ZuXkMX3Nmw4ez2M3RxL986dnGRiIx9UGWK+q
	JZPoW3SMfTd6NsqVaOAdTUkVDEEaJquGIB+Zxolg613U9secCLiGZ4Vt6VSkHFzygESNtbt+rR6
	Ey5a49Cd1LY8g4TNfeW1/O46weP22ER/UYUTcb04CpQ6ERDOw1otzAkv9cbhAbmEkYNPrsGD/lx
	RLAZpSRjYWQ2nu8Or6nqk2OXwc2mevVSId3jo20VauYosMzuOg5NvHbjO57lDOIEGCkXPAwHbdH
	ZCn8gJ7xEMmylnP0F+lmnr/X3s1LMhRFshhTTT3e+nJlUue4D/oPiEyRuEkuHwCPAhZ6I4BXAWv
	akgw+dPBA==
X-Received: by 2002:a05:620a:1a21:b0:8cd:b024:114d with SMTP id af79cd13be357-8cfb9ea6bb2mr485207585a.40.1773930600903;
        Thu, 19 Mar 2026 07:30:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc25f0340sm87627185a.1.2026.03.19.07.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:30:00 -0700 (PDT)
Date: Thu, 19 Mar 2026 10:29:57 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	kernel-team@meta.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, osalvador@suse.de,
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, jackmanb@google.com,
	sj@kernel.org, baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <abwIZd7FNPj5YYXQ@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <c10400db-2259-4465-a07e-19d0691101a4@kernel.org>
 <aZxqP7J1kOClQUPQ@gourry-fedora-PF4VCD3F>
 <aZx7hsVNU0XOCCiG@gourry-fedora-PF4VCD3F>
 <049d056b-844b-4480-b90e-bf4c850fc70e@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <049d056b-844b-4480-b90e-bf4c850fc70e@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14913-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[72];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.963];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gourry.net:dkim]
X-Rspamd-Queue-Id: CF4DD2CD10F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 02:05:53PM +0100, David Hildenbrand (Arm) wrote:
> On 2/23/26 17:08, Gregory Price wrote:
> > On Mon, Feb 23, 2026 at 09:54:55AM -0500, Gregory Price wrote:
> >> On Mon, Feb 23, 2026 at 02:07:15PM +0100, David Hildenbrand (Arm) wrote:
> >>>
> >>> I'm concerned about adding more special-casing (similar to what we already
> >>> added for ZONE_DEVICE) all over the place.
> >>>
> >>> Like the whole folio_managed_() stuff in mprotect.c
> >>>
> >>> Having that said, sounds like a reasonable topic to discuss.
> >>>
> >>
> >> Another option would be to add the hook to vma_wants_writenotify()
> >> instead of the page table code - and mask MM_CP_TRY_CHANGE_WRITABLE.
> >>
> > 
> > scratch all this - existing hooks exist for exactly this purpose:
> > 
> > 	can_change_[pte|pmd]_writable()
> > 
> > Surprised I missed this.
> > 
> > I can clean this up to remove it from the page table walks.
> 
> Sorry for the late reply -- sounds like we can handle this cleaner.
> 
> But I am wondering: why is this even required?
> 
> Is it just for "Services that intercept write faults (e.g., for
> promotion tracking) need PTEs to stay read-only"
> 
> But that promotion tracking sounds like some orthogonal work to me. What
> am I missing that this is required in this patch set? (is it just for
> the special compressed RAM bits?)
> 

Yes, this was specific to the compressed ram bits - it allows for a
service to control where/when writes to the device can happen.  In this
case, I've limited writes to just the demotion step. (Although I have
since realized i need to not allow file-backed memory to be demoted).

There may be a better way to do this, but also it may very well be the
case that such a hook is just a bridge too far and isn't wanted. I think
this debate is warranted.

~Gregory

