Return-Path: <cgroups+bounces-3838-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF14938AC5
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 10:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EA1281AA4
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 08:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A40160887;
	Mon, 22 Jul 2024 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z9fXb9q9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C38282FE
	for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721635727; cv=none; b=icr+bd7z8pDwtDInTxMiKt5QWOKI7/DC7KkVJ7amw0a2XpqRtjj6bm4Ose/ciexlCG6UDETiKabLwqgjn7JpEjxPAcglm6KHqG0umKmscIrpR++0ufNkNM/bZ6IS0/T/RRe2QgWfvFMZVQ1VtSEc7v0fg+ciPSheAcAN/xF8bZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721635727; c=relaxed/simple;
	bh=Dz9ebkowd7HaDAuVc9zZBTkWzpKLGDLNZaDE3oRF9kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y53psghvrACeu7Xx/H29j/pdascYHXPMeyjmIk70KBusA9dtE6EqE/slb2CvorlubmySE8/r/exBrBvVRisXCs/YjXMpURM6prqV7Q7q5jgjsweE5V8Ft96yFhPM3lJteCzgBRHgPZFlIR+hjt3C6NclwdDRyJEN0uYYFKErucs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z9fXb9q9; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a22f09d976so4463734a12.1
        for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 01:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721635723; x=1722240523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Wd6Cxr9N48/+xuD2e19M+YM6ch6z0+BUK831e99L6k=;
        b=Z9fXb9q9RSbfEq+qdlZo8mHJPDwfwF0pGHOH5PuBSFrrGmtRT+hCfm4vFyRwyNJ1fn
         TGGw6UHVVEXHzXMERqFp9cY7DiWnH4Uxt8++J4uaZc8ZBNXUXSbtjRKMxyqBf6taFMc8
         RxxG/akvLiPGyDZtNJUone5L9j0jg5S7Xgw1G/aub7KkPJesnNmD7IBplb/W1dSyGCr2
         Bfx3vp38c5YdgqPD4DLJs7PVE/r2PdbvltG4545euVbyf9YYsQ7GpZy5pzfELrrtUmUd
         YLrorGIfUVcrE2GNeF0SP7pFnWGfYTzncWki7wP+46T5JkeuWVE3o/KwXNwQ3C1aHqxS
         fhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721635723; x=1722240523;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Wd6Cxr9N48/+xuD2e19M+YM6ch6z0+BUK831e99L6k=;
        b=rhbZCYw2KWjiWti/FDHzU6kCfkDScDFOqpesagtouV5SaAYBEaUx4dhpJxoWcJuRQB
         Y56WrJ32vyNoNIS8jtqo2wUzPVcHk7RJlvYqrv5rlGJ3QSHlFxbMmV6B3kdLLSH+2Tf5
         2HCcQnaT5rk+qsZo0N3Q8AbLU6NoFyI3YjP91TtZYZ6E8E3mPviqd1qBiA5DzII6UvRM
         kh8SB5bnrUzyJpJ4bgLFnLaAa+I0QOuwb+zKRgMhr1674ilh8Z4+eLCeDX50/rzRqpwT
         uspV0l8CFuSi6b5YF7/WimYbD4h4ssZh0RB7E0UXJvWiLs60MxYbEkyaIW0C9izFZaKp
         EZiA==
X-Forwarded-Encrypted: i=1; AJvYcCWC8rQsFQJcTPV0qem4WwOURESdgFRa6Dn677TwV7kOxmnaeAdCUdWgePZIjYe1A18NMQcnueeupq6ygU47nzTJCSh4PNCcVg==
X-Gm-Message-State: AOJu0Yzb6stswOBzlArhk9nl1WNXaDr1jBnZBnT/5s7THK05t/Q0y+3U
	vhieNRmhAgeQdZmV0QnZ34i8rinpV3YOklMjkZbx7aLrD9sbEkn0ELn3W5n6JFQ=
X-Google-Smtp-Source: AGHT+IGCRBjXz9y6hDA2TppmI58v6fD0LApEdpobjR38zRDMKp97lr+peWsJDLRYuCXEsVuIZv+GXg==
X-Received: by 2002:a17:907:b9cf:b0:a75:162c:3fd5 with SMTP id a640c23a62f3a-a7a0f79cf20mr1340481166b.28.1721635723161;
        Mon, 22 Jul 2024 01:08:43 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d318e67e8sm525312b3a.206.2024.07.22.01.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 01:08:42 -0700 (PDT)
Message-ID: <417a3dfc-152c-42b4-8883-06b3c6381ea2@suse.com>
Date: Mon, 22 Jul 2024 17:38:36 +0930
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] btrfs: always uses root memcgroup for
 filemap_add_folio()
To: Michal Hocko <mhocko@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-btrfs@vger.kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 cgroups@vger.kernel.org, linux-mm@kvack.org,
 Vlastimil Babka <vbabka@kernel.org>
References: <cover.1721384771.git.wqu@suse.com>
 <6a9ba2c8e70c7b5c4316404612f281a031f847da.1721384771.git.wqu@suse.com>
 <20240719170206.GA3242034@cmpxchg.org> <Zpqs0HdfPCy2hfDh@tiehlicka>
 <9202429f-e933-4212-a513-e065ba02517a@gmx.com> <Zp4LnZS3MSqzM08J@tiehlicka>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <Zp4LnZS3MSqzM08J@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/22 17:04, Michal Hocko 写道:
> On Sat 20-07-24 07:41:19, Qu Wenruo wrote:
> [...]
>> So according to the trend, I'm pretty sure VFS people will reject such
>> new interface just to skip accounting.
> 
> I would just give it a try with your usecase described. If this is a
> nogo then the root cgroup workaround is still available.

I have submitted a patchset doing exactly that, and thankfully that's 
the series where I got all the helpful feedbacks:

https://lore.kernel.org/linux-btrfs/92dea37a395781ee4d5cf8b16307801ccd8a5700.1720572937.git.wqu@suse.com/

Unfortunately I haven't get any feedback from the VFS guys.

> 
>> Thus the GFP_NO_ACCOUNT solution looks more feasible.
> 
> So we have GFP_ACCOUNT to opt in for accounting and now we should be
> adding GFP_NO_ACCOUNT to override it? This doesn't sound like a good use
> of gfp flags (which we do not have infinitely) and it is also quite
> confusing TBH.

The problem is, for filemap_add_folio(), we didn't specify GFP_ACCOUNT 
(nor any other caller) but it is still doing the charge, due to the 
mostly-correct assumption that all filemap page caches are accessible to 
user space programs.

So one can argue that, cgroup is still charged even if no GFP_ACCOUNT is 
specified.

But I get your point, indeed it's not that a good idea to introduce 
GFP_NO_ACCOUNT.

Thanks,
Qu

