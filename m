Return-Path: <cgroups+bounces-7628-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15820A92C0A
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 22:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F143BC257
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 20:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A6E2063DA;
	Thu, 17 Apr 2025 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfmBXFjr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B281DDA2F
	for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744920620; cv=none; b=BTMlrzTYpRxpxaI/LBrGUvYRCHqdZsOFsDya4m0d8C3TJkOOPwGCZWiAw687EnHwWnv6OTKkCgJ4cFrFCWApbGYoRrsW/glFbjKq+jJ53iSIhVnKSIs6ZI/92gMeOuj9seDx+OYGb2oXcGV1hxbPfAuVke6j8PfTIHdEiO8zBRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744920620; c=relaxed/simple;
	bh=1ZR7rByE57xHmBI7814XXbJjV3yJ8MgPosTbLBX91zE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bDhMBhx5ZDyytiuWpiA4FDMmt92JGUlpDuOJCX1QmJtlEftxx3MG5nYRMP2SCyIMurgU1V9KW4mbJRzF4ZXxag7/tWXUuViIXrs1OFGjMmReyXtvX7qLXh6KW29w6UP2/z465jLjPmKJf0Xv0Ef3x+Wc8CU0LSCAg6lIyLkZ2wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfmBXFjr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22c33e4fdb8so14679235ad.2
        for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 13:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744920618; x=1745525418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UZ9CzFa621uATTSaULP4s96x8JmFYzdGBES+TbEIHRE=;
        b=OfmBXFjrJb+ABzl6tqaY9c6Kl35hMqi8MjhqyRNdi0I5TcptfZe9/znuWNhRpg34/c
         5c0S1YNFv/o88ii5m5mTfQIubNgkG1ogRgNpPhHMUJ2Xj2SPle60/J70dGRc5umFz962
         4PMrcFM4P6y2NuwGuLg754Te7hFzbwDpMjHXbl1pMiCXrg0aX0uTrBfjvU1y4TeB+YpV
         tdVbDbFT04BnWQfST/QGYOnMFGFs5O6x6F+SxvV1HVpinsaePjaN8yw34Ft9h2Xc5jgi
         dZrVy1dLN3ZulRKqJ+yzLaKUxY9HCQgAXThd7LmIbsOdsn4bBwtxRhBiuEAoGQ718pn0
         UCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744920618; x=1745525418;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZ9CzFa621uATTSaULP4s96x8JmFYzdGBES+TbEIHRE=;
        b=mxBaTrkhX3FWROOtHNwuRryNhrXnL8jnFqYpdtlnqDoKUcvByQkNKVpoo995jzhNM+
         Wlgl2ETv4ucCw1tpqVEAT6wi0mWL9Z0svgndIXkdpKSR+87aKMyMR+PyGtYAL4mjxe0Y
         XqcdRQavSIVQ/TOrAyinSwYLAUJYOQ22I5GTBDybXqAZECVoEGj+PKo0RlY3n3Ghhj63
         C2khtlFV0tScEsWtciGayJQaRqO8DlejspYUOTZPZkgV+oWtfUe5Fv0IBvwaTbc5He5w
         AfvP6Lqo39/+zMYc+hfKh7XQKQ0ryjyn8FFd92F5dEEYfBKAV5QxLBA+ModslunRH/zT
         UF/w==
X-Forwarded-Encrypted: i=1; AJvYcCUaANaXI26OSu5XTZzwp9JrvGh/5Zp7pP+SRa6H4OddyN5a1MsRYB76J0z1MSc3pfRvdWOLw4S8@vger.kernel.org
X-Gm-Message-State: AOJu0YxcmUMynn4IwBBv9JjccrmKbUAS9Xac+HD1ajxQEn5tFXM/qTcI
	wpcwxgUXBOEINyeEMXswzZiTYQoKtN5JqgshLzXlkspmEoiADP2T
X-Gm-Gg: ASbGncusR5rOSw4IMAMgbAvZq1IRl1s1PrgIGn5WKpSBU9uYdwxb1jAUgiuzpdRLkkR
	1CWUKt9YhNLRYbYCR4/iKxXN2Y0QpwyI+XtBMtizTA6BPSX5lPrWlII37F9+rq14plph2FiBgHm
	A+bbXFmWQmFzsLG7nHe0m5kd2/ZM0wFth682XRO5K/55H9b6iCY/4YXcZ33mtESuCeXZPx3Qsvi
	hWiiXoTHAjt4Bk9EBwoSupRcYUz9zzixaBm3DekArr+LdU8n9qPrHbORncGw/Ya7abZILuFbTTS
	KWJXLD+BDUuOW+GZZEAqpQxuc/HHSyFGzgfLKLmq9JL+2CMzz1zZhF6zlYDtZKknG8j23miv
X-Google-Smtp-Source: AGHT+IFu8TvrOT7mfZlte7YEsHySoAvhmP73oO9Gk3cGuB1EeFBjmVGx38umUR/hSO0hUwEMZUynqw==
X-Received: by 2002:a17:903:3202:b0:220:faa2:c917 with SMTP id d9443c01a7336-22c53611075mr3914835ad.34.1744920618125;
        Thu, 17 Apr 2025 13:10:18 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:6f0c:5f5a:e370:874b? ([2620:10d:c090:500::5:a81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fdf1dbsm3988915ad.258.2025.04.17.13.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 13:10:17 -0700 (PDT)
Message-ID: <f95735b9-5d92-47a7-a7d1-15bfb3ef8a9d@gmail.com>
Date: Thu, 17 Apr 2025 13:10:16 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] cgroup: use separate rstat trees for each
 subsystem
From: JP Kobryn <inwardvessel@gmail.com>
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-5-inwardvessel@gmail.com>
 <2llytbsvkathgttzutwmrm2zwajls74p4eixxx3jyncawe5jfe@og3vps4y2tnc>
 <88f07e01-ef0e-4e7d-933a-906c308f6ab4@gmail.com>
 <oi3hgft2kh44ibwa2ep7qn2bzouzldpqd4kfwo55gn37sdvce4@xets5otregme>
 <337ce68f-5309-4bb2-83ae-cb43268f447d@gmail.com>
Content-Language: en-US
In-Reply-To: <337ce68f-5309-4bb2-83ae-cb43268f447d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/17/25 12:05 PM, JP Kobryn wrote:
> On 4/17/25 2:26 AM, Michal Koutný wrote:
>> On Wed, Apr 16, 2025 at 02:43:57PM -0700, JP Kobryn 
>> <inwardvessel@gmail.com> wrote:
>>> Hmmm I checked my initial assumptions. I'm still finding that css's from
>>> any subsystem regardless of rstat usage can reach this call to exit.
>>> Without the guard there will be undefined behavior.
>>
>> At which place is the UB? (I saw that all funnels to css_rstat_flush()
>> that does the check but I may have overlooked something in the diffs.)
> 
> It would occur on access to the per-cpu rstat pointer during the tree
> building in the sequence below.
> 
> css_rstat_exit(css)
>      css_rstat_flush(css)
>          css_rstat_updated_list(css, cpu)
>              rstatc = css_rstat_cpu(css, cpu)
>                  per_cpu_ptr(css->rstat_cpu, cpu)
> 
> Since I'm doing the early checks in css_rstat_flush() in the next rev
> though, I was thinking of this:
> 
> void css_rstat_flush(css)
> {
>      bool is_cgroup = css_is_cgroup(css);
> 
>      if (!is_cgroup && !css->ss->css_rstat_flush)
>          return;
> 
>      ...
> 
>      for (...) {
>          if (is_cgroup)
>              /* flush base stats and bpf */
>          else
>              /* flush via css_rstat_flush */
>      }
> }
> 
> Then we could remove the two conditional guards in css_release_work_fn()
> and css_free_rwork_fn(). Thoughts?

Correction: just the one in css_release_work_fn(). In the case of
css_free_rwork_fn(), there is a call to css_rstat_exit() which would
still need to be guarded (or it will touch the per-cpu rstat pointer).

> 
> Note that I was also thinking of doing the same early check in
> css_rstat_updated() since it is exposed as a kfunc and someone could
> pass in a non-rstat css other than cgroup::self.


