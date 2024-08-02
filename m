Return-Path: <cgroups+bounces-4069-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDFC945626
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2024 03:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6682281F36
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2024 01:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC0F17571;
	Fri,  2 Aug 2024 01:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1ZaMZU7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DDEB67E;
	Fri,  2 Aug 2024 01:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722563804; cv=none; b=jMyo5ZmiwZtzymqLjGS5nQ6zJWRkb1Fke31re6akEBES/UZVVGyYQOGHFj3D7UPsYU9oYJkk+Bf8hu75xrwRwv1CFIyHoW4g40as9QYkTsk7I2LcOB2ORqI9G4CEKDQwe1hl9SzI1M+k4M8j5I50mtguxENDIoAUNjVi0D5YO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722563804; c=relaxed/simple;
	bh=bEwvbBKgwUm95B0DvqZT1H/saqC9aOlJiBXMdLWTVcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCXTAE4s094/S+UM8mlzjua7ZbGf78RA74YOFujwLS3KAAqjlyY6hN+Q73xaK+PUa6yO5mJunRJ4hwtRdD9D3Ju6E30luMjKEavC8T8Vmlo3BikziFUKPC6LzfWzD8GfsTSqrLuEyweCrmuZZt4+HCPoTS0t8zedvZK8ZUSYJho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1ZaMZU7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5afa207b8bfso8027235a12.0;
        Thu, 01 Aug 2024 18:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722563801; x=1723168601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtHQhobldpJJPQmPYcIkiHl149A/gyJJkr05VI99uUI=;
        b=k1ZaMZU7aqESokpSXmuAnOlj/nci+0YM3Z0CkgLOOBLABk77BfvIFDl1btZVYvp8yy
         XQEITsJMV7/FK8RnDMLOR8sI0t2W0BTXIqqMdkHr1Cckk7TNLGbRP4g8npb7tLp9Hxm0
         hT2jguF8Nd1sucsZgdK/gMs4+S+Oh2pFHxcZcHpFzNSGWdbCACs3DW3XPgWf4PFLjeHW
         /LtfePF5YAxgGfzuK0W4fxvxf8V7embrKp0l3A4dejzucexv6uI2PNar3e43DGHnnRMP
         TdVY1mkvBjJIiNMVezLGZcaCnLfOm7VUVcnBPjkF6ydeiP87m45ta7IEJax+Nn96IzOf
         yWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722563801; x=1723168601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtHQhobldpJJPQmPYcIkiHl149A/gyJJkr05VI99uUI=;
        b=q4rMT/N7JG8uYCS6JV5sqVhYDHV0k/6DrD7lzBjYybhnhsQ7+H1q1xuJjZ90ASCd9K
         LLSRisNvo/66F0LRZ61Ebh0+9OYjcs/ps+68KceQIYU0aiMBnR3fLg65HLlu5pZ0xEZg
         hfpzs0KCtgz54+K5oeqMY/7GIxppgjsghX0HX/bb4zG/NCfa0QvGVwWuIy6aEq8ROD0/
         s6tEfQmz9tXg9hksDhf3CLQTIYdKZNZbGOShF1F7C51WRjGVVWkMLo2rvbzRQIPAhxvK
         6UQtdrQ3zde+OpYJSZoBMve5gTYAQSHyYx27DFdIq8AINs9aGQqCuN/ax5CUK8VhE/tJ
         9ynA==
X-Forwarded-Encrypted: i=1; AJvYcCXQS6dP2Jy10h3kx6y5wm7xqyzzrXv9ySShNE9VVbhEMM6LAhbgG3sS/MTvkMmux4VM4q/m4aPIX3WlXI3sJnZhzTYnNO2wJYYAT3X/3uOqOLndPm5uKp7Bs4F9ipsLKyyPL3BtMQ==
X-Gm-Message-State: AOJu0YxnvtSfurlukgoN49Sq2ujkHPfLsIv0fJGm4AgsIMcxYF43j7ur
	ZgqWrLtxMVRwbP+IZJsjlfmwUVAQDakUERcG8WERs3Fv5f8NPRH/qAAJlH9Ykz/oqqSapa7yDo1
	4O9QjTLUsTPM6JSwNcdbMxaMjM5A=
X-Google-Smtp-Source: AGHT+IGfpycLUw+2FFBR3cE2zymB2hyFOpnDRwpucSUMZ4M7PitiCU0H+n9vg8QOwC+Ul5yDbrfFO2+oCM03kmWzlSs=
X-Received: by 2002:aa7:de99:0:b0:5a2:abcb:c4d1 with SMTP id
 4fb4d7f45d1cf-5b7f56fe773mr1337568a12.34.1722563800666; Thu, 01 Aug 2024
 18:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801045430.48694-1-ioworker0@gmail.com> <2527d5a4-de1f-4c93-b7ee-fdd6fbe2a6f0@kernel.org>
 <CAK1f24knBez71sEvcfFoFuyvap+=3LzsRrmW-+fLsqV3WkyMBA@mail.gmail.com> <iedonwzoqj75yeaykgovdufi53cu3ddsrqfhdfui5kgwlal6pq@mdeue6pc6byz>
In-Reply-To: <iedonwzoqj75yeaykgovdufi53cu3ddsrqfhdfui5kgwlal6pq@mdeue6pc6byz>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 2 Aug 2024 09:56:04 +0800
Message-ID: <CAK1f24mOdm6YK=3ZY4QE2eQq4ggeiNKoq_Nhp1bguE8E5jBwBg@mail.gmail.com>
Subject: Re: [BUG] mm/cgroupv2: memory.min may lead to an OOM error
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, akpm@linux-foundation.org, 21cnbao@gmail.com, 
	ryan.roberts@arm.com, david@redhat.com, shy828301@gmail.com, ziy@nvidia.com, 
	libang.li@antgroup.com, baolin.wang@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

Thanks a lot for clarifying!

On Fri, Aug 2, 2024 at 6:58=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> Hello.
>
> On Thu, Aug 01, 2024 at 07:40:10PM GMT, Lance Yang <ioworker0@gmail.com> =
wrote:
> > However, if the child cgroup doesn't exist and we add a process to the =
'test'
> > cgroup, then attempt to create a large file(2GB) using dd, we won't enc=
ounter
> > an OOM error; everything works as expected.
>
> That's due to the way how effective protections are calculated, see [1].
> If reclaim target is cgroup T, then it won't enjoy protection configured
> on itself, whereas the child of T is subject of ancestral reclaim hence
> the protection applies.

Makes sense to me.

>
> That would mean that in your 1st demo, it is test/memory.max that
> triggers reclaim and then failure to reclaim from test/test-child causes
> OOM in test.
> That's interesting since the (same) limit of test-child/memory.max
> should be evaluated first. I guess it is in your example there are
> actually two parallel processes (1321 and 1324) so some charges may
> randomly propagate to the upper test/memory.max limit.
>
> As explained above, the 2nd demo has same reclaim target but due to no
> nesting, protection is moot.

Ah, that clears it up. I appreciate the detailed explanation - thanks!

> I believe you could reproduce with merely
>
>         test/memory.max
>         test-child/memory.min

Yep, I just tested it, and you're right ;)

>
> > Hmm... I'm a bit confused about that.
>
> I agree, the calculation of effective protection wrt reclaim target can
> be confusing.
>
> The effects you see are documented for memory.min:
>
> > Putting more memory than generally available under this
> > protection is discouraged and may lead to constant OOMs.

Thanks a lot again for your time!
Lance

>
> HTH,
> Michal
>
> [1] https://lore.kernel.org/all/20200729140537.13345-2-mkoutny@suse.com/

