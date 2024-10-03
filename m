Return-Path: <cgroups+bounces-5023-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B53FF98EB7E
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 10:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F711C21F66
	for <lists+cgroups@lfdr.de>; Thu,  3 Oct 2024 08:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D77137923;
	Thu,  3 Oct 2024 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V1Q1bDyY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB38F84FAD
	for <cgroups@vger.kernel.org>; Thu,  3 Oct 2024 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943795; cv=none; b=d/uTuY3x5DYh+VTeFLklok3uIEpso9y6wJhPZ6rF5/PmopPx6t+FLBbv0jwNSsv9e8CZjopyMbbl73RXds1B+/cpalEHypyp1fByrWrk239IXWr+VsUgYI1N/nXhts80a6EVYEw18R3ZFz99diboqb9uahX6lkbEZGb1fvB01A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943795; c=relaxed/simple;
	bh=IXuUsrxA1n9NZm7RPSDB0asPgiGaulWPK8Wrf8q2VLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E64qwMWh56cGXojpwIkR9ubCmltklZZlOElTUHFaz8/ME4SolHj+vmmG35UDOshXLx/Z3f1pmUEUywfeitYBsZ1O9LO9X1RgxGKhgaF0k2TTEcVjSLQ4HckpmX/hiu1yci9LlBW7i/f2zUPxs5eiKNrbL1moxdJIEkg+OFoiWQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V1Q1bDyY; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso7262941fa.0
        for <cgroups@vger.kernel.org>; Thu, 03 Oct 2024 01:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727943792; x=1728548592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iFODimp1QE4G5JcljKakMWGS2TTG5DP0ztUxHv1oO7M=;
        b=V1Q1bDyY68A28LPKCtG2bP7bowrotDhwQmKH1wyinO4U1pR6zKSAI+pthmnE/rHu08
         Kq9ZlN9V7/cfwOSe467e1u8WbrIsFN2Y4/iIKyaD2UX157dru795hYCgCq0mlubsPglA
         +M4ztD0KLgc0kYHCppIgBNPpImbeFOpITCM2eyHdE+oQRtigYs08q955QPHo2aCdWzwj
         AuusDz8/cWY+G9+6Ym3oFFmxacjp29xkDOUTf604X9Uc5S7OOzkyWIoY8F7T+6g0/x3h
         QFK1iVBCl0OEc92lPZ2NIqIAhGmLVcaGPu8S+kqgB8fcX80NsgaShwUsV3okrYbUKLzf
         tIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727943792; x=1728548592;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFODimp1QE4G5JcljKakMWGS2TTG5DP0ztUxHv1oO7M=;
        b=e8nHWm4tN45xbjn7VGPAt5I7FFS9gRcfIx+bARK9RmRwZPQukGI8e6miGCEbJxIiS3
         qq9ZqDGnX4Nl4ZdeJl/+hQt2pIP+iQc9cUgGyBFiGWVBXLLOyGpniWqWqzfkoOJMzV9n
         Ls+XpH6V9GCKtRNArmOtE4QP18cMl//2OGi+uVCj0ya6RsE2sJZFDoUNkui2T/o3cbp3
         NEf2IWNc9BYOcI9EsxL57mUCmnIODYmMnflkn4LRXBgh/aYAjRFbSQFmBOUO3zWtztdn
         hYv3E4hwspoKdQnpyC+q7swcmxsdxNaEwSvy0WXn7CyGSTYSC2owbWa04Kmmjq6Y8Art
         NIOw==
X-Forwarded-Encrypted: i=1; AJvYcCXTgT5exMfG9hFKv7R/Ud2kFc4YORjUapTe41bDzrQ3QcafQzf07E5WX23pyTzDVdHa3yd0Ql83@vger.kernel.org
X-Gm-Message-State: AOJu0YznuJcWgCP6APRURZ+Z4q9ala9bLda50F5+OdNvg2cFOSRKs6Aw
	pzqhm5PlVvJ2POkWc+94NBTtSe7NZmKqzeqL4hGmIFzdkZk1Xo/m3L1w7Z36SDQ=
X-Google-Smtp-Source: AGHT+IGfSRJS3R2zaDRNfM0V0fPAIEIIjjVBxdwQMJvU7MyMU63zQ9t5U8Zub5+zr0REtiC/4id8Nw==
X-Received: by 2002:a05:651c:503:b0:2fa:cf40:7335 with SMTP id 38308e7fff4ca-2fae1029a7emr34867571fa.19.1727943791335;
        Thu, 03 Oct 2024 01:23:11 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeca6fb0sm4725385ad.75.2024.10.03.01.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 01:23:10 -0700 (PDT)
Message-ID: <362b90cc-d6b3-45b2-a8a2-52387267b33a@suse.com>
Date: Thu, 3 Oct 2024 17:53:04 +0930
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: root memcgroup for metadata filemap_add_folio()
To: Michal Hocko <mhocko@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org,
 linux-mm@kvack.org, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
References: <b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com>
 <Zvu-n6NFL8wo4cOA@infradead.org>
 <5d3f4dca-f7f3-4228-8645-ad92c7a1e5ac@gmx.com>
 <Zvz5KfmB8J90TLmO@infradead.org>
 <b43527db-e763-4e95-8b0c-591afc0e059c@gmx.com> <Zv5UPLRBDAA17AA4@tiehlicka>
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
In-Reply-To: <Zv5UPLRBDAA17AA4@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/3 17:52, Michal Hocko 写道:
> On Thu 03-10-24 17:41:23, Qu Wenruo wrote:
> [...]
>> Just a little curious, would it be better to introduce a flag for
>> address_space to indicate whether the folio needs to be charged or not?
> 
> I would say that an explicit interface seems better because it is easier
> to find (grep) and reason about. If you make this address space property
> then it is really hard to find all the callers.

Makes sense, thanks a lot for all the help!

Thanks,
Qu
> 


