Return-Path: <cgroups+bounces-16796-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RVmjFGjCKGqyJAMAu9opvQ
	(envelope-from <cgroups+bounces-16796-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 03:48:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2416654EE
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 03:48:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=HD5oqS1l;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16796-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16796-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1FBA3050442
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 01:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1638A2C21D9;
	Wed, 10 Jun 2026 01:48:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885DA30F7FB
	for <cgroups@vger.kernel.org>; Wed, 10 Jun 2026 01:48:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056097; cv=none; b=JCPaBsy5ar4I8TlGmhLaAbLQYfD7ZgTANB1enGeob8JBNA1DqX1gKDapt1LVRcjghIXbuTJqx+rxLPmhZw8tMgHUXIrs86VcBgv+ze+a2VZP6orcWWjk8L/KMWKOpYO+b2ntxjWLslQUDtTxAV/h9UI0Le/l8j87LdF+76v+/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056097; c=relaxed/simple;
	bh=Vt+IdxbWB1L7vusm9WG/HXeAN8VBkLQnH1HLbOEK6s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKA0K0jMomojtw2gSkXBthdHU8yywk6M5FLa+/0uMY52BrThVbxT1zKs0XNtnKMx27ONJTX99Xlzdr0C+h+R80YrOz2Z9SW0XQ0mEl7M4EymRJV2tU8mLqclShdkuXtzQ+0jIIubOQH6XjQzLyRzJC6X4PsX23Tx0e3wTftb3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HD5oqS1l; arc=none smtp.client-ip=209.85.222.170
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9159f631656so724595285a.1
        for <cgroups@vger.kernel.org>; Tue, 09 Jun 2026 18:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781056094; x=1781660894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7uGDT/wO/h2postfHb76XgCexw5pCTGWL/5zE3J3lk=;
        b=HD5oqS1lCtVBDf3UzATm3sC7R1SmBOvpdwM2qj1k7PiUwlFtyxKuav/YKiVLxLo6na
         a7DpCHjdIpld2eeXprYMmg1N1XPK8J9lcuLStI/UvooZHtdAvdXQoPc3LtjNF+rO5IiZ
         uXSpfTTc5v+euaTgrn8JMsinZ7dA45yhVgzEBYvM9Epu7haGE+5Q18FoJiaCM7VEP4zQ
         fxxPJcVU7Ag8Lq/Ai9+4HsDkRsJMbTPqE+0tKstCmwsGoHUxhAxI6otVPQGQ6esezRcY
         T6y91xHeVDjnwwGBUfAd+8XaLJUj14gAeyXK9zbVde+LRVV3MIO7U1yh2cWUBVv4h9G/
         dpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781056094; x=1781660894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7uGDT/wO/h2postfHb76XgCexw5pCTGWL/5zE3J3lk=;
        b=Wbgot84TSxe52khyApG2oK7LdqVTw8X4IXbrK1xGTbQPRrwJpUEwXsGEZpceHJ4MbR
         Txh/KQcfTMeXrvuX3Lj1mCsyvWAqbMTpgUVfWGMi0eQ5kEH2Uc+7YgDHSu2S8B3BORxK
         mvIBlQixHMzuyIj3MOqi9dgagpJz5sZqUMWhJZ/rUCKlEGaN9iVbABEMsvLu+sb5/7+t
         Ac7uPjXTk89HScK8Rw3Bk7DJYbtGgA+elmKXC6OcEA7Co7Jj7wP8l30M2AaOYNiXLFKL
         Q5kpSg4Mf6GKmDjUevayQMTtDFHz2pIdQlWwbsPgcF08A64beZQ+hof9usGiRA/oHZVO
         s/FQ==
X-Forwarded-Encrypted: i=1; AFNElJ/IzeVWe1mISm/DgwP+Qtbqnk2DpNFxKnIzu6D9dXjkigDqj1HLv+JBuG2xTd7Zltwt7SiPbLJ9@vger.kernel.org
X-Gm-Message-State: AOJu0YyjgnLEBJOLmph2jH6v9chBO1aiP2xI2xZoYgUim5grqUvjOWWX
	Sf9Cum0ZkMz8O2dAgPW54t42GFotmFy2n2CHR9/30e5lIYyGeg7AF6u1+q5Ar3RHWvY=
X-Gm-Gg: Acq92OHSujXX3kGihrf+ysUp6eEtmd06bXIiWCY2NfZiENvBo9Jj7iaGL9kCnN9jj6I
	TkZuGspPb/MF1Enn91pzQWsRgT5N3dz6LGOF7TgDkZ4lySKXtcP2BpwwKjpDLz51ftoHrL0spe4
	FtmMjxmhNkd8O5/0A2hKubSBfd4XDGfPlTkkK/WOVp3yCZbVKENFR2eEeRukNKCEI8Yd7fe3Bfk
	/3FeqW1IXO0NivNd3WLIWaXjbRm2ZnBnt8N+L/cZnPrLwP8JuRryX1wCEqwoHd/rtNRvuqtW5eB
	RmmIqW+GAWNAhCHqAKD0kYSZco1s3zo4c0DmxFwOKO3uohoZB9UKQNAh6kmIEFrGKVZ9bXRNP5t
	ncyfxo57SQSkCljkPERnEorEiMzci6yB9wl+vtl25rQ6odgf45cVh8v7Cf4ZDQmAkZGRK7G3sOj
	k9ajFiB6bIFRFBmXKgNzyhWG510kdp40pvV03vphyR/r3JweJwiIcvTdYcFcM45aCT8QieBuk12
	fuLYpZqWW6DzasZTQ==
X-Received: by 2002:a05:620a:1a20:b0:8d8:697:1cf2 with SMTP id af79cd13be357-915ad2f7e0emr2592726185a.30.1781056094343;
        Tue, 09 Jun 2026 18:48:14 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37cab6sm2274803485a.22.2026.06.09.18.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 18:48:13 -0700 (PDT)
Date: Tue, 9 Jun 2026 21:48:11 -0400
From: Gregory Price <gourry@gourry.net>
To: SeongJae Park <sj@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, kernel-team@meta.com, longman@redhat.com,
	chenridong@huaweicloud.com, akpm@linux-foundation.org,
	david@kernel.org, ljs@kernel.org, liam@infradead.org,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, kasong@tencent.com, qi.zheng@linux.dev,
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, rientjes@google.com,
	chrisl@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	baoquan.he@linux.dev, youngjun.park@lge.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, jackmanb@google.com,
	ziy@nvidia.com
Subject: Re: [PATCH] mm: constify oom_control, scan_control, and
 alloc_context nodemask
Message-ID: <aijCW3RWWX9_wccj@gourry-fedora-PF4VCD3F>
References: <20260609002919.3967782-1-gourry@gourry.net>
 <20260610001937.77371-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610001937.77371-1-sj@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:kernel-team@meta.com,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:rientjes@google.com,m:chrisl@kernel.org,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:youngjun.park@lge.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,m:ziy@nvidia.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-16796-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,meta.com,redhat.com,huaweicloud.com,linux-foundation.org,kernel.org,infradead.org,google.com,suse.com,tencent.com,linux.dev,gmail.com,lge.com,cmpxchg.org,nvidia.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE2416654EE

On Tue, Jun 09, 2026 at 05:19:36PM -0700, SeongJae Park wrote:
> On Mon,  8 Jun 2026 20:29:19 -0400 Gregory Price <gourry@gourry.net> wrote:
> >   */
> >  static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
> > -					nodemask_t *nodemask)
> > +				    const nodemask_t *nodemask)
> 
> Seems the above indentation has changed for a rason that I have no clue, and
> also introduced a line having both spaces and tabs.
> 

It aligns the const with gfp_t on the line above.

This is a common alignment throughout the kernel for any function whose
prototype spans multiple lines.

Thanks
~Gregory

