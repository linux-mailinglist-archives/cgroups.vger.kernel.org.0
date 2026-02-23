Return-Path: <cgroups+bounces-14149-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE5tNeF5nGlfIAQAu9opvQ
	(envelope-from <cgroups+bounces-14149-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 17:01:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D111179423
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 17:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F96130225B9
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 15:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FCB2264B0;
	Mon, 23 Feb 2026 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="cpy5aLQg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3D42F6565
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862331; cv=none; b=FExLAyn1VK4vlcghkR9thaaLGNSqH/sf3Oh3Xh01V8C0QGcCLTNUdAyRVdbTZyMpYZl6znCTPLY6fDQMpV01kbJHAtVc/6tZX/4vmDGb5gdQ6Kqy4AO482Q4HZoseph5XQJBku7IkxwIYnydvaaXRsGLogCIgwi8CSTr6Nt9vJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862331; c=relaxed/simple;
	bh=+6jS37I+1wbJ1iqlKg2dmc5dYnQE3LyFGZ64dOrbW/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcI6NKoVW6o+23iVuo9uNKtPeZQDISBFlyzQjZ1s0eaX9hyfa5v7EDQYIgh2SUXRKnsK9yVfwOq0beGZPsr6toNUzH1nt91FY6a78s59iW7BDy4L9JoW+GcyRwXfe19mn/48sVfTNkoMuP5hszQo97FgfQbPeh9nkzVhT3jzw4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=cpy5aLQg; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-505a1789a27so27409221cf.3
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 07:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1771862328; x=1772467128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gJlVVB4cdcMuEQ3h5OcyXP3aNJfq5CueqYlheuqsqJs=;
        b=cpy5aLQg4pfEGyz5TaDuHhTN64LtG66GHLYcvhqrcV4xUC1pLJ70uSjOo5vTkuOHn1
         nnNv/f3j/TKT1xJ7hBp06n9YTbKWBAT3w0Q0y8rhBwr6Nth9dxRNg81SkGwccoWq+HPw
         Wqdc6fTGHjuVqPUZD47vpaMjaEr9Qtro7pxfucvjNaiVq8VTlqPOWxNWGYbDWmH7Imsr
         HzHeT61m9lnKYOC/HP1ean/ePZ6AsT8s5jmVGnsqWP8mi8ynWqGJ4SAlL6GxmQeyb0iA
         Dq8dDmYdkYSEcGjsoWw0DAiAVjALzAHgaTpls70b8m8ImVJf31GoVORK+gp6P6X7RoWi
         FFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862328; x=1772467128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJlVVB4cdcMuEQ3h5OcyXP3aNJfq5CueqYlheuqsqJs=;
        b=SvDgJf05MXdmW5yvWRbbwmjwtZk8Qfx1YEe+xexSSlZd5M3Hv6WXME4HeR5EbFl5nM
         X60jzJWzjk3odLvJWBV6C+PkwndZ7yUQu6/dOQJlCzm/zKq2tGi9Gq8WqOZZX6t+4wPJ
         cAHd9cppH8cBSPrjk9YGiFg0aDC7XLqEfrSEjS2vaYrzOJClbogdYwDP3ZZesICZaAec
         mhwkTInOXrzACXjxfNwVy+XfzrAB1fELilhe6Re8lJ3vgxM37W3L1hnKXUmldOOF+pCX
         3yMghW/HR3YuDcBXM6byWxaatcfpwugCrSFt1gLVt23089svlPGFoEPTzP6d9CT//E4l
         2T/g==
X-Forwarded-Encrypted: i=1; AJvYcCVmM8DoTudzPEWfJXSwpaw03EaOfLsxWJiS8QndUQM1rhWdt+wyzFEjwR9XJLuyMwKusQDItVmv@vger.kernel.org
X-Gm-Message-State: AOJu0YxoKE9j2a4qWORcbH9mzcD2jnBiYs/+ZyfQqLI5srfkCEHHY5d0
	AvlT0THAeF7pn2KiAUJhk4jWL3YyMc4RAqDJX22slznKldNuVZmWgptIDbSlUI2LBM8=
X-Gm-Gg: AZuq6aLIDDr5TDh+EqCMJmUWQUD1mUOL8QcgX/fKT1NZJUl78H4YGvOqVovlL+e+zf2
	FGo/UPDACMT93GI2O1oRflrPwGmast9aRY3TN3CVXw/mDXgBKFp93MEMqmh1u05zNwPIQ+04Q1x
	fUP3cyWQJ2vmi4BUcP/DzjFm6gp5ZBUlKSLFvxzSd7ihAhyM0LUwsgkP6dG/bDVFwa0AdAJu0hx
	+t0l8Uw+Nd5St2TdxApuFWhHE85Xfu13G8o7jfkVDB4hD0z6v20fczpFOnsrTQoPGvnblP1VnEb
	MVnHJ53AmHBEwE2DBKDLPqkSNWXmMSac+3JYjuwOJWHt3NpgeIU5wzrNVXHYvWm7K9ZQ7j6QRdN
	lJNU6J2eHEobpeBWGQTTq6K9rs3zolBvDfY944hr79roc6+5G6tO6fztOLlPUcBw0pgCIZ1QMA2
	r6B2VBZ+BC10xiRp+L4kNJBA==
X-Received: by 2002:a05:622a:181b:b0:503:2d06:8e1f with SMTP id d75a77b69052e-5070bbcd9b4mr109231921cf.19.1771862328143;
        Mon, 23 Feb 2026 07:58:48 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e24627csm71706556d6.29.2026.02.23.07.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 07:58:47 -0800 (PST)
Date: Mon, 23 Feb 2026 10:58:43 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmalloc: streamline vmalloc memory accounting
Message-ID: <aZx5M2WYMK7pKhC1@cmpxchg.org>
References: <20260220191035.3703800-1-hannes@cmpxchg.org>
 <aZjaxAi-AzyOYzNT@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZjaxAi-AzyOYzNT@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,suse.com,linux.dev,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-14149-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[cmpxchg.org:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[shakeel.butt.linux.dev:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,cmpxchg.org:mid,cmpxchg.org:dkim]
X-Rspamd-Queue-Id: 3D111179423
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 02:09:28PM -0800, Shakeel Butt wrote:
> On Fri, Feb 20, 2026 at 02:10:34PM -0500, Johannes Weiner wrote:
> [...]
> >  static struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
> >  {
> >  	struct rb_node *n = root->rb_node;
> > @@ -3463,11 +3457,11 @@ void vfree(const void *addr)
> >  		 * High-order allocs for huge vmallocs are split, so
> >  		 * can be freed as an array of order-0 allocations
> >  		 */
> > +		if (!(vm->flags & VM_MAP_PUT_PAGES))
> > +			dec_node_page_state(page, NR_VMALLOC);
> >  		__free_page(page);
> >  		cond_resched();
> >  	}
> > -	if (!(vm->flags & VM_MAP_PUT_PAGES))
> > -		atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
> >  	kvfree(vm->pages);
> >  	kfree(vm);
> >  }
> > @@ -3655,6 +3649,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >  			continue;
> >  		}
> >  
> > +		mod_node_page_state(page, NR_VMALLOC, 1 << large_order);
> 
> mod_node_page_state() takes 'struct pglist_data *pgdat', you need to use
> page_pgdat(page) as first param.

Good catch, my apologies. Serves me right for not compiling
incrementally.

> With above fixes, you can add:
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks! I'll send out v2.

