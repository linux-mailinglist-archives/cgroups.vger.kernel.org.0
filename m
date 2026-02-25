Return-Path: <cgroups+bounces-14361-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFMbHdPonmk/XwQAu9opvQ
	(envelope-from <cgroups+bounces-14361-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 13:19:31 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76246197275
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 13:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2BC033003714
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 12:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD8F3AE6E7;
	Wed, 25 Feb 2026 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K04LkvhF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706FB2DEA8F
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021966; cv=pass; b=O7nAN3tR6jXEDl9lh1mWFqzaPdXLCuWtUYdtzgWMPvv7rJzooxdM3v3eM3+AnxOeKuIcMPwA0aE+hR8cAZfwOU3bk7TAsYNEhHtpEfD1U5MwmBacEw1f+6L6mpn9RudRTNXzL2sYSDCp2VAAYUlK5C/a0MlV4PsuhMfXpuc8Jfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021966; c=relaxed/simple;
	bh=5GivVNyIA8JAZFbbK477torhwiVkLccEddGHhqwOeMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIfnfldEQVQNUN2koG9/A5tx8eV7CpmZvNwpVT6meKQvL+vnCO7zIf8P+/jh+PjCHBIKbeaa7MzLHKszOPYcvHLdda/n7QQggJbjmLyTub3RZ17N9rFqpUY0lGwDhRpK5u8L0dPH72s5hgyHR4zvj1zuoX2lCr3hb0dGDkKML5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K04LkvhF; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506a019a7f3so83923441cf.3
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 04:19:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772021964; cv=none;
        d=google.com; s=arc-20240605;
        b=V9yG3JTLOeXBBYa7iF0hDnYEc7W02vaHiWEDmYQIImAz3qkNr62yOGzMEfsSPxKQq8
         GJ7xQHmZF8ENhNtTjoGDo5L4XkMbekCMI/ag/JvFcpGSOKRhsRbMsPsnhzaBp+j3vI5z
         GnX53UJYewNBDWz4DCZaGp/dcFiezuxp1X091XoXh9i79hdv+4sLKnCJLMCwaGSr7T2B
         yCQ0qCIC1vxZcCsrDpFjyieTjC9egHoZ68+WzxanFn0TOQHI3AfCAjGbM02ejAsY4Xsn
         Xvk3ByyfKa+0UhIl2S5Aw/k7T009fFINL7qbXQgIC6+SxPxmC7VnHUJXwmknoeRZD5zu
         qb1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5GivVNyIA8JAZFbbK477torhwiVkLccEddGHhqwOeMg=;
        fh=fLwoKLa+Y/TI2t8gbLu9+BoV7Z5ynOdn6i1IjZ2UqqY=;
        b=XGbUA+plpcsruYAhetNw0UeuMLFR+5EsB7LUBfBbglKXo+9ibjijgT5liuM3/QYr2d
         lyS6y9vq4ZlQAC4uTSw2Nf7N9/TNzkb0dgBEKsE+V1gB3JSfra1cxq5eqpuxnn9vuwJU
         u2HRdVD48mboKOFb1cV3di8jl1yxde1KHOzi5ZpFVNZnGnwTz8MsUam3xZQ08EZGKylF
         Dix6OUmy7s1nGtz8ID5pwXQwoHggqo4Qw5bGJxQ0bPzvvZ0t+BKRIKCzWyGTsGsyCs04
         ZC6J7qY2EbhZWSw/ECKcNIZLI9m8V5bK04gNexOaF2TmF0lMS+tcJ/w+PiudMOLg7CHZ
         UTcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772021964; x=1772626764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GivVNyIA8JAZFbbK477torhwiVkLccEddGHhqwOeMg=;
        b=K04LkvhFjIHd/a4A0la6HG2BdNnEqA/3bikRoBSQjWAE+yNFRkXtALhqtv04A3MK4Z
         d5jUmWMkSPcpUG995Ujp4xTdK/fCi1C2PchXw4DdBnf5eljyAerIXAfsYVyKmmNeh1P5
         HKc1QGL2xIXW4fjAr39JGnvny0kGODZEuD5ADEilt25Cj7Uuf8xFUKsz8KrxKqz/zzgL
         B5eKabZVojKhkA94h2SsljGbuntuwKXMzt6+mPxV7zGxZpbJz4dFdQ3tCxoaJ1+Jcpy3
         +cWdyjluuRpb34ryDA3ayFNkV3qaf4ixILXGn8GjqQY1vluJLUHH9uy2eqZ64a3vwkPT
         lUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772021964; x=1772626764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5GivVNyIA8JAZFbbK477torhwiVkLccEddGHhqwOeMg=;
        b=LYyR5B9Vqsn0u0CJaOIN0gSuG4nIMq9ffBzZ96e2xsL7vL94fcmoC8PxusrdsPgOuS
         GISJnElmDsw+px0R0INzao7sKvpPxkHcWbGOXjDeH32Zo7GVyKhoCh5j0EfT32UrQfUC
         8CYDfD3AiU1B39pmprZ6mJhwOqyOgH8AjQ7ob+KXJOAn8nevK8BbsW5gm/2UzK5beci/
         laxaWHzi1xL9LCWmch9BUrPQ+g1/IjHmyvSXg23tHDKaFxSi6Ldrfr/dglX4BWjplz4c
         eFF2L0A8MfsUhYG/U8oGVk/74HxerfO7cq3asz/9c3+FfvBpgVtIEDT+An+CPKJCj7As
         dRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOCw2YiZKAg+n8QYzmukUFLogmpwZeVcq2QJOsr5Z7H1eRI38tbYNmdghIIVp5uSvgMV2SIiEu@vger.kernel.org
X-Gm-Message-State: AOJu0YxuNhUh5dCP41vEfpz4KNWGpDROF7eI5U/CdJ1lrkuJxGe7gcVA
	duWfwgqusqeRH8zjPdzq/JFOcFAgpCfbmGT4GB/BkUemlqcJSnTm0SovI7pzuKUIXlgEOfU5cZ1
	73hOI4if/oMr4LHyA+X4gzZS8Z3HmADk=
X-Gm-Gg: ATEYQzypc3oP8RYraUEHzRBs0UNSyogP64PXpzcgPIEKnIF1lkuUMRXPSS010VNccad
	2XfH/IWdCnQdfg3f+er2iBRZOs0nmLvOR+RROieBNX4B7iWC4BTG2SFJ0Tlwi2+mFDTHsnNAp1l
	AVfDZd82t5fq7agtAeHgVhFShcXjmX2x/IyFJO9iYYo+DZq73HFbtxqxQIowbuFREyW+M0DVTbZ
	rU8oGdRhNcg9quIoIcEbKrPWxBeizzPYTkOLopcfVuFwuqzO8JOYtQ5immREnvHb2oYYFc23/Yf
	o/pjCQ==
X-Received: by 2002:ac8:7f91:0:b0:506:9ad2:8d4a with SMTP id
 d75a77b69052e-50741fcfdd3mr1385691cf.75.1772021964065; Wed, 25 Feb 2026
 04:19:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com> <20260220-swap-table-p4-v1-12-104795d19815@tencent.com>
In-Reply-To: <20260220-swap-table-p4-v1-12-104795d19815@tencent.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 25 Feb 2026 20:19:14 +0800
X-Gm-Features: AaiRm511TxBGRVuIyMzvT0fAaZozlquA48wNCycgFlMQWIgQStFaENf0SwcgBCQ
Message-ID: <CAGsJ_4yv31utMTsZcRf5adeUzC7NnE0DfMKRFi3v1iCxfdXbdw@mail.gmail.com>
Subject: Re: [PATCH RFC 12/15] mm, swap: merge zeromap into swap table
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14361-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,oracle.com,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,lge.com,bytedance.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[21cnbao@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 76246197275
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 7:42=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> By reserving one bit for the counting part, we can easily merge the
> zeromap into the swap table.


Hi Kairui,

I know you're saving space by removing the zeromap memory,
but do you think a bitmap can sometimes be faster
than iterating over multiple data points to set or get bits?
Or is the performance difference too small to notice?

Thanks
Barry

