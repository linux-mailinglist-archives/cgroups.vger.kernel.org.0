Return-Path: <cgroups+bounces-4994-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9D898AF89
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2024 00:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC361C212EE
	for <lists+cgroups@lfdr.de>; Mon, 30 Sep 2024 22:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E837218786C;
	Mon, 30 Sep 2024 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vuu4CmQu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E90183CB7
	for <cgroups@vger.kernel.org>; Mon, 30 Sep 2024 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727733648; cv=none; b=iDi1TahxHSpGdGZ3w7v30TEue2tTegzSeMclGb/O0M4fmaXLSkMLrBBxCy6stb+k8zZlMHmkjN8Pq1g1jF0K7MVqaF824I/vpDbxiI3k8PqzabFV019kMW+H5IZ0BDRB9iGW1V4GLN3nzKh4BE0zWVMQPwdhze4drT/BVtrFSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727733648; c=relaxed/simple;
	bh=jTnVQLl6lOpdVV0MDuhMVodo1CWb5dEOmoMSel4V8Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLJWcwHNVAqVxXjlNywx0GkyUblLVbxQDQOkKqabSMaq5FBU637wgvKjJQ9CXyNmsGFJESr7vxEubITy4p4WHdUtGJk8EgbMgCg2AqDRh3g3VSB8yalg8umu3X1YYliLgqVsPqrsTHfVxbXwzzrACztcE+mfCrhWZIWiyRHFack=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vuu4CmQu; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37cdac05af9so2734509f8f.0
        for <cgroups@vger.kernel.org>; Mon, 30 Sep 2024 15:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727733645; x=1728338445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L2mFpUOHLDzVxx/ZIGFl4CWIEl1Ta1q5zyxabezUC7o=;
        b=Vuu4CmQurHz+wDbzD8z4bi17XqRnSRKNGEA2yT9gNX0RCpnorauVyAqj7Nr6jZxOnv
         jeaZ+wKT4A8f3/U/8eoI8d6j04XcW0BeeCKXA/AhuwxPEL28VK4JOR6f/Fq2OTapkMXV
         lMYOvDgnOaLRots+w4dPOYtLDKqHonB4MM7Bp+F15B/uw+v0TckZf5O2XdbGGU8SPpNt
         cz4RZTAAetIuSaLbcKtyV3pRDMjHtlhMCA2FyP7CUew24TBlAuPPF+SvnKGd27SuGbDV
         NEAVEOvSYPDscIIMAOnOhpVEGznnA26i8rKNICi5xafb8zZy9a149BN0cxjVHukqy70w
         jSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727733645; x=1728338445;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2mFpUOHLDzVxx/ZIGFl4CWIEl1Ta1q5zyxabezUC7o=;
        b=L0yan22dg4Twik3BoyLaC3tqQLcRGRtL5LxPCfp0Gh/3ZAOT42QJTBQrMOz4Lz2ejQ
         RVB98aHDPVAdeK/5rre7eD8HmebY+BzA5nC2vEuK/Gta6SV58GxEYH4ofamTarGxB5LD
         HYwChWyxAp+XcuNsBD+TjR/9NRxkl3qJNZIHUxTI+Jz/sCV2Q+4ub6wF4r8Nd6jWCY16
         PDs0B5k86doW+KVYtI60zcJM7X0TdU0yVMt3k8jR8ua5AO6ootAbW8dJWViTy2UVJjD+
         qxaaBr3XQJPErarKYfDN2FoP+3ZHaPCmpiDmeSYyLfrAUy5rl+vZ6gtYDbbNa83kDC+H
         zGGg==
X-Forwarded-Encrypted: i=1; AJvYcCUM26MKLwaCFJwES1Dk49nWbBDLlykJk3SDw1zjesGjxj5SD0df4ULsHs397kIHjpC2DES73KnW@vger.kernel.org
X-Gm-Message-State: AOJu0YzoXaUK9s+ENYScXiWmxoxk9KSk+wxZVGJZOyXhDORwVCAgyLoM
	5HmI9u9o+GaiwcZAGLge+QgAqQDB8cGV9+7gwmPJ67qUZsusvqeY0F3JfGbwSWhgEXxJB3adQRX
	PWUQ=
X-Google-Smtp-Source: AGHT+IHFYeBKfI1EAN3zAjxXMPApcDZWCKA60zfD/7mFgkcgN9iCUPnZcVes0tbuxzyWue7tmWzc9A==
X-Received: by 2002:adf:b31a:0:b0:374:c3cd:73de with SMTP id ffacd0b85a97d-37cd5ab1164mr12881784f8f.35.1727733644688;
        Mon, 30 Sep 2024 15:00:44 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d92386sm59082215ad.90.2024.09.30.15.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 15:00:44 -0700 (PDT)
Message-ID: <08ccb40d-6261-4757-957d-537d295d2cf5@suse.com>
Date: Tue, 1 Oct 2024 07:30:38 +0930
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: root memcgroup for metadata filemap_add_folio()
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-btrfs@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
References: <b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com>
 <iwjlzsphxhqdpml5gn3t3qt5zhizgcmizel5vug7g7bwlkzeob@g2jlar2nynqb>
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
In-Reply-To: <iwjlzsphxhqdpml5gn3t3qt5zhizgcmizel5vug7g7bwlkzeob@g2jlar2nynqb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/1 02:53, Shakeel Butt 写道:
> Hi Qu,
> 
> On Sat, Sep 28, 2024 at 02:15:56PM GMT, Qu Wenruo wrote:
>> [BACKGROUND]
>> The function filemap_add_folio() charges the memory cgroup,
>> as we assume all page caches are accessible by user space progresses
>> thus needs the cgroup accounting.
>>
>> However btrfs is a special case, it has a very large metadata thanks to
>> its support of data csum (by default it's 4 bytes per 4K data, and can
>> be as large as 32 bytes per 4K data).
>> This means btrfs has to go page cache for its metadata pages, to take
>> advantage of both cache and reclaim ability of filemap.
>>
>> This has a tiny problem, that all btrfs metadata pages have to go through
>> the memcgroup charge, even all those metadata pages are not
>> accessible by the user space, and doing the charging can introduce some
>> latency if there is a memory limits set.
>>
>> Btrfs currently uses __GFP_NOFAIL flag as a workaround for this cgroup
>> charge situation so that metadata pages won't really be limited by
>> memcgroup.
>>
>> [ENHANCEMENT]
>> Instead of relying on __GFP_NOFAIL to avoid charge failure, use root
>> memory cgroup to attach metadata pages.
>>
>> Although this needs to export the symbol mem_root_cgroup for
>> CONFIG_MEMCG, or define mem_root_cgroup as NULL for !CONFIG_MEMCG.
>>
>> With root memory cgroup, we directly skip the charging part, and only
>> rely on __GFP_NOFAIL for the real memory allocation part.
>>
> 
> I have a couple of questions:
> 
> 1. Were you using __GFP_NOFAIL just to avoid ENOMEMs? Are you ok with
> oom-kills?

The NOFAIL flag is inherited from the memory allocation for metadata 
tree blocks.

Although btrfs has error handling already for all the possible ENOMEMs, 
hitting ENOMEMs for metadata may still be a big problem, thus all my 
previous attempt to remove NOFAIL flag all got rejected.

> 
> 2. What the normal overhead of these metadata in real world production
> environment? I see 4 to 32 bytes per 4k but what's the most used one and
> does it depend on the data of 4k or something else?

What did you mean by the "overhead" part? Did you mean the checksum?

If so, there is none, because btrfs store metadata checksum inside the 
tree block (thus the page cache).
The first 32 bytes of a tree block are always reserved for metadata 
checksum.

The tree block size depends on the mkfs time option nodesize, is 16K by 
default, and that's the most common value.

> 
> 3. Most probably multiple metadata values are colocated on a single 4k
> page of the btrfs page cache even though the corresponding page cache
> might be charged to different cgroups. Is that correct?

Not always a single 4K page, it depends on the nodesize, which is 16K by 
default.

Otherwise yes, the metadata page cache can be charged to different 
cgroup, depending on the caller's context.
And we do not want to charge the metadata page cache to the caller's 
cgroup, since it's really a shared resource and the caller has no way to 
directly accessing the page cache.

Not charging the metadata page cache will align btrfs more to the 
ext4/xfs, which all uses regular page allocation without attaching to a 
filemap.

> 
> 4. What is stopping us to use reclaimable slab cache for this metadata?

Josef has tried this before, the attempt failed on the shrinker part, 
and partly due to the size.

Btrfs has very large metadata compared to all other fses, not only due 
to the COW nature and a larger tree block size (16K by default), but 
also the extra data checksum (4 bytes per 4K by default, 32 bytes per 4K 
maximum).

On a real world system, the metadata itself can easily go hundreds of 
GiBs, thus a shrinker is definitely needed.

Thus so far btrfs is using page cache for its metadata cache.

Thanks,
Qu

> 
> thanks,
> Shakeel


