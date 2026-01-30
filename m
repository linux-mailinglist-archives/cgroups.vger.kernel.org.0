Return-Path: <cgroups+bounces-13527-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLPBMRz8e2n4JgIAu9opvQ
	(envelope-from <cgroups+bounces-13527-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 01:32:28 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0592FB5EF1
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 01:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FAEE3005327
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 00:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E876285056;
	Fri, 30 Jan 2026 00:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="t598jZfD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE6A27FD7D
	for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 00:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769733142; cv=none; b=YcUdK5BcUEwuhs5XjjeMLDKiMlbs8E1q6k002r5TEIH7I4YlSxiD96vWhTJ7J/wpKDHorUJrNv0PtBQv2zl9a3FvgiTzpqKvQ5ah5vB47gXTihMHkavdMa+rKob82AfgrmdEkDOj/uLCH1qQDE7TfDk0UKPED7EILV6wnhC47QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769733142; c=relaxed/simple;
	bh=fmza5biRGBTWmrLX3TvfAu/KOFH2b1W1A1c2gS0GfmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6f/6RDN7MJAq6bCygpKTYb68p8gJc9iixXHbwbNsJVhJaykkmZKGlUVvMPyR7c96Z9+R4D47sJmXMpipgb5SZzD0laftFbMMbimwIou/wTA+GTUGCt8/FbdcKUBmZ+D+LUVOVCEVwnIxNKtiVWVrTnaW/ak0R++2krH4+qNwbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=t598jZfD; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-894638da330so15757636d6.1
        for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 16:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1769733139; x=1770337939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPUXRmfIX+IoXHHYz7SljCky5Hdp8sH/+/BEOo2u/kE=;
        b=t598jZfDC5DQkVhO49mKPundgOadm9DqR8H1CnI6mYeriNVDntqpoCBJaNaO53ZV8i
         NZHfaFW6govE+/R6tJipoIagKLrTBuTLPhwJLmVyGETdQF5Yq781t5VxK5zlRX2Ic+Nj
         ggK3wWtaH4XF2ILR8Yt5Vx8JRyyjI2ZX2RZLhX0+MVfTrwG1WMAmIAehz/gPB9j8qRi6
         GAW26y6MxAntPC3KHW52xz0EbTKjnyGOdDS2IJrJ9ufpNVbjuQmy4UkXJSshEpmP4h2w
         M4J13+VMR1i7cUYmuW7UNTSJsiDsPP7GB0/PBP4LB4cnbfumRHeL+OyGiip5hjcA+cJx
         e9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769733139; x=1770337939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPUXRmfIX+IoXHHYz7SljCky5Hdp8sH/+/BEOo2u/kE=;
        b=Vj0ovINzdwc0eReEawJUzfAMf1DsUL53/abcZT1mdkh7AIz7kOaVAfT7kncx1ZbKll
         8U9em65qa5qG3s5qa70s3rDGhFDlNg0hyPwOwcRqQywslOrSsPzllGI+yF/XetXNwg9n
         Z9Pbfko/c6K5WJkf9MZ8OtHa4QWk3APf2G7GhWsfKe1Lp3u1pzMTaAiGwsIVukRuaWId
         EjrNKYWg66PJzbRMJ05QkHLWrVd4QH40+DDvgpOP0jmjfZNDhmCO6UTsazA/5gr+Pha/
         8RRG0gpS6JgClshZNVB/yJC8mSA5OLOTuM6H9rqBgSl9wkOypqEUB/kGtXmFoJE2l9Ll
         l3Og==
X-Forwarded-Encrypted: i=1; AJvYcCVNFYfidi2ZX7xaxh9rMSPwhp2b2niPOtxcSBNZEyuNaD5r1Xqgx7tA04MeUniygdSzennESSz5@vger.kernel.org
X-Gm-Message-State: AOJu0YyMSQPJamkYmCiy5gNpRB6qQsMKePTYFKqi5YD8SB7qxksEK1HH
	FFxzQSu5+GEOe9b5InsytjyFG1ODuFeK2T3lLq31JucjG1nVT6Ts+huNtwY+tvUhKM8=
X-Gm-Gg: AZuq6aIK7ZjzyVFg3s4erbNui4dSPi7vEw5pOaXn0isjSJSAfoFNwLkH6nVXBc+qE1N
	IzDfB0q134csofhhPSG6oRgRfmoVlVsHQz1+21GZj3tnDNwpm+n71vAHerFmb7PmK7Fz5k2R8Wh
	fAY4bIFNcHDJ3HqKMArIHrPk7HNADAzvwow0lEGq9Ukf2pjqyJqqgm6dgBKR7gXV4FC2wwQciPH
	9mAerIY3uG68WUzQfUI6TvUFps/NCYcdnKdRJ+4fd7Wt7MBIYXwa2Wf0Kwgel5TEESMxHPx03nR
	ikyPKJT9h4Wr8+LhwcNYAcGdrHSLjj1IA6V7do/qFyCppxWifrIA2TusTlN0dvNZQ4o5r5v5PhP
	iF6Z9K7YuLC85hORqUbKquPlTv3sDWmD0IfPALN22cY0A0qqetheqFYQnYjIYcQXeyVCIQAi6KL
	sogUxYt8YVVghalx7s4pYa
X-Received: by 2002:a05:6214:410a:b0:80b:11b7:210b with SMTP id 6a1803df08f44-894ea058f0amr21222026d6.43.1769733138680;
        Thu, 29 Jan 2026 16:32:18 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36c448esm48949356d6.14.2026.01.29.16.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 16:32:17 -0800 (PST)
Date: Thu, 29 Jan 2026 19:32:14 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rik van Riel <riel@surriel.com>, Song Liu <songliubraving@fb.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: khugepaged: fix NR_FILE_PAGES accounting in
 collapse_file()
Message-ID: <aXv8DjjJ3zqZEsgQ@cmpxchg.org>
References: <20260129184054.910897-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129184054.910897-1-shakeel.butt@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,surriel.com,fb.com,kernel.org,gmail.com,oracle.com,nvidia.com,linux.alibaba.com,redhat.com,arm.com,linux.dev,meta.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13527-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cmpxchg.org:mid,cmpxchg.org:dkim]
X-Rspamd-Queue-Id: 0592FB5EF1
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 10:40:54AM -0800, Shakeel Butt wrote:
> @@ -2200,8 +2200,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  	else
>  		lruvec_stat_mod_folio(new_folio, NR_FILE_THPS, HPAGE_PMD_NR);
>  
> +	lruvec_stat_mod_folio(new_folio, NR_FILE_PAGES, HPAGE_PMD_NR);

The memcg breakage is more visible, but I think this has been broken
for NUMA stats even longer. new_folio could also come from a different
node than the subpages, after all.

>  	if (nr_none) {
> -		lruvec_stat_mod_folio(new_folio, NR_FILE_PAGES, nr_none);
>  		/* nr_none is always 0 for non-shmem. */
>  		lruvec_stat_mod_folio(new_folio, NR_SHMEM, nr_none);

So AFAICT NR_SHMEM needs the same treatment.

It looks like that's been broken since f3f0e1d2150b ("khugepaged: add
support of collapse for tmpfs/shmem pages").

Anon pages avoided this, because their accounting is done in rmap.c
when the pmd is mapped and the ptes zapped.

