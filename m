Return-Path: <cgroups+bounces-7140-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4A2A68334
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 03:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4824B3B8863
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 02:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5886B1CF284;
	Wed, 19 Mar 2025 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq6hSfm7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D213DDB9;
	Wed, 19 Mar 2025 02:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742351891; cv=none; b=r8qDlI2jU5TJT2x3x0hA1qidxbSfXi3s8secxYKlh6wAYE19vhR/aKQLsiL/k4NaptA5qBkz4IxlSGI+HBki4EjE4e0OuXqVLmxczLBm+w7ol7KbEKmvMzX8J2FIxq09LCvFrVe2pPNQ7XHJbJjXZ6kafvdOneOXCLsindlzSh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742351891; c=relaxed/simple;
	bh=tUOQuvlno9rHPWwRUOE5YWFNQqJnjUsmpriQGb3JZx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7NdY/ejCuYsDbC+i309s+P/FZqjqqaFehQIDUbTmd6K0FmmIY5dvixaDn0C1kfh+cUZCEoW2EP7zHCXeAHouKbrhHn1bq/idT3O/0MXjA0/cBn7UG73kNs01Jwi7MhjdBEbhIdyXFj3ODws3EAiAl5lOmNmzNAaLFbxtCsZp3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hq6hSfm7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2255003f4c6so113605175ad.0;
        Tue, 18 Mar 2025 19:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742351889; x=1742956689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uiqpvRP3XPxWm2NV0PkZWPKnAddXpi1Y8S8sPBln3k=;
        b=hq6hSfm7Ye8rt2Iu3fFkA4mTVMf/NnJZtHdFYktRRl9Y8vEXu63f3Ot/uhkdbRCBwl
         QY1IRvpJWP3oV4cFHrj3JDBsU8kjchf9eH6nNpaS7d5N/Bnh1Vc/WiVGNYinqW66rCOk
         bWnBEBq5nk2qHTXKNfiL4iGR0RbKNGNzUkZPyKSFM66eQe14+YkXS1QvFmv5W/c4CURg
         PXNrd0MVNpQcvxWXcatlshHNa9yAxpE+Jmb89UV5rFxZACCiOgir/6wA9VC4RdKTEAuQ
         fYomu0+rhhPocYaTkW0zez0nj1uwl4QfY+NHtcxeqwH1KG9jvozl48Vrp9vM8BKuutpa
         RFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742351889; x=1742956689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5uiqpvRP3XPxWm2NV0PkZWPKnAddXpi1Y8S8sPBln3k=;
        b=d5EmFEXEDX+VwTfOGgXszE+91m3fmpjT3BOky2k+YotZJXCHvVl491dEWHBnTaEgaj
         uRgnLDkWSKNVxujjYPDTSk21BZkSPycmxzX4cMha0jyH5AqAB/kZvR2rtKzCUz5GhQPV
         49lXfeh2bscGTkoEr8U7ZANSQHXURNSaFSVnLFrzMNzKTuk8DR4s8ttDLwm9wubPHY2I
         U6DTuxFkuiC0Ld5868tsr8TqeU60dWG3UL9gCgz797oW83mcWSU1SYK2aqqyUUxbu44b
         Qb7RjzC3o8PyofSk/OvZsbVveVd/BkFPU6YHrWIioazd5IlGYMTG95TrGGPsS47qnSgd
         j+fA==
X-Forwarded-Encrypted: i=1; AJvYcCUTc2FuVGg9a0hAqin9Gr+oPsffHrA1juOGz5k3vB6ccu1ml6cSd94Vy2u4+bLTAnGlXADkNJXKRy4HKu66@vger.kernel.org, AJvYcCWKkRUzcxdbleq4wwXBR94sQ7idkVzAegU8nLo7qKiXUNI3lkc7Dj0sCziCBg4cGpkHmVWc8GwGi4R0@vger.kernel.org, AJvYcCXZzjSXiLP8x0biWDjaMi5cUJGXr7bgS+yS8BSinhagjR5dQYn2TwwQSl91gVrDNF2LkzvOWlwU@vger.kernel.org
X-Gm-Message-State: AOJu0YzyNitHzODZ2gnlng0SmScRiTGn+Nh55kok+rETn8Hl53icj5E/
	HeoyyQ+FA8u4hjn0BkJeOnDDjKECc0KOLnGfEI+pWWJK7sKsCMBR
X-Gm-Gg: ASbGncu77NV/moK9e7L33G7sfAT5SL/T4BAHo6OAqDSafEsNH4iVXvRfSSGfDbW2j+A
	9JkMs5Pf5p75fevwbkSHwQOP2Z5A9dhcUZNJKyv9lV4F74CDsZlhwvOrvNrJ9TigN7dwiqq6dER
	d/77uhrssT7VeOkEvhhwUajiolxTp5dZwiPSrOHF+g3uH/HG9Sh5pWLt6fPgRe4LbTeBkCgXU21
	imnW5jrs8Rbdu0V1S795vvoeWrCMZvHjtO/4zOi4TPKRVtFzOiAvB1yN8EUJKjMNMFW85V53Nrh
	I+e3nTYlrvXmODlaWH0H9YIpQRHQMrpA7VqIQCXWtW/fxPOsb0QwCLh7Q1MssKPVFg==
X-Google-Smtp-Source: AGHT+IHKyMKAM+xsXy3cTomkkroHHXDIVIxP3TgfYLDXmikYftTTRgJgKY4wnTP8KzR6XjF6fyhYdw==
X-Received: by 2002:a17:902:e84e:b0:223:501c:7576 with SMTP id d9443c01a7336-226499248aamr13132675ad.12.1742351888857;
        Tue, 18 Mar 2025 19:38:08 -0700 (PDT)
Received: from [10.125.192.74] ([103.165.80.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5a7dsm102526865ad.251.2025.03.18.19.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 19:38:08 -0700 (PDT)
Message-ID: <b8c1a314-13ad-e610-31e4-fa931531aea9@gmail.com>
Date: Wed, 19 Mar 2025 10:38:01 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
To: =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc: hannes@cmpxchg.org, akpm@linux-foundation.org, tj@kernel.org,
 corbet@lwn.net, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
 <20250318075833.90615-2-jiahao.kernel@gmail.com>
 <qt73bnzu5k7ac4hnom7jwhsd3qsr7otwidu3ptalm66mbnw2kb@2uunju6q2ltn>
 <f62cb0c2-e2a4-e104-e573-97b179e3fd84@gmail.com>
 <unm54ivbukzxasmab7u5r5uyn7evvmsmfzsd7zytrdfrgbt6r3@vasumbhdlyhm>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <unm54ivbukzxasmab7u5r5uyn7evvmsmfzsd7zytrdfrgbt6r3@vasumbhdlyhm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/3/18 20:59, Michal Koutný wrote:
> On Tue, Mar 18, 2025 at 08:03:44PM +0800, Hao Jia <jiahao.kernel@gmail.com> wrote:
>>> How silly is it to have multiple memory.reclaim writers?
>>> Would it make sense to bind those statistics to each such a write(r)
>>> instead of the aggregated totals?
>>
>>
>> I'm sorry, I didn't understand what your suggestion was conveying.
> 
> For instance one reclaimer for page cache and another for anon (in one
> memcg):
>    echo "1G swappiness=0" >memory.reclaim &
>    echo "1G swappiness=200" >memory.reclaim
> 

Thank you for your suggestion.

However, binding the statistics to the memory.reclaim writers may not be 
suitable for our scenario. The userspace proactive memory reclaimer 
triggers proactive memory reclaim on different memory cgroups, and all 
memory reclaim statistics would be tied to this userspace proactive 
memory reclaim process. This does not distinguish the proactive memory 
reclaim status of different cgroups.


Thanks,
Hao

