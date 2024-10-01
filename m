Return-Path: <cgroups+bounces-4997-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A160098B200
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2024 04:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940C81C21405
	for <lists+cgroups@lfdr.de>; Tue,  1 Oct 2024 02:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1100F2CCAA;
	Tue,  1 Oct 2024 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fPLkRW0i"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6D29CF6
	for <cgroups@vger.kernel.org>; Tue,  1 Oct 2024 02:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727748235; cv=none; b=a785MgssR6KAI8HJb9KGDrOQAEvdqxCg9DSgh9jhCpV5gCX3oN4D65xE6t9/YWOtIfTsCFish8hbRXpAsWAMdkTH0Fm5Y8f3KjCoiF2TNjL4VDYtwQ5hfQv12iX1zW9kNsO/WQh05jlc467FqIPJItjFEg3MPu484kdpl+auX6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727748235; c=relaxed/simple;
	bh=g1a0EVN/7dJu0bj/tIDSSC1ZRUEYufySY/9ZSZLQR2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMkCQWgswpSrGraYM1a1vMA7eMM9av/PvYRO+gRArTYJD8v12sYDvKZdZ1g/HMHx2ck3SUV6xZzkxGojBHaSWnrUtdjugGPmChZmgKbxdPnqD6ScSQBWo78Mrg8NUDCKU3edt4BrNF+uupB/eQV+vKlFe0uMq5FP8OpJO1tKUjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fPLkRW0i; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37ccd81de57so3095263f8f.0
        for <cgroups@vger.kernel.org>; Mon, 30 Sep 2024 19:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727748232; x=1728353032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y2XJ1eZ28xIo+GDgkaOimxZFzT7dJYCNXgTF8/d60Ik=;
        b=fPLkRW0i7Fp+5iEEkVXy0tmkH/ggSyx5GdQFT+ppIbwvKH+u2UAgNAA21SbUBZ4e6x
         VHA0aVnS2/y7vySAlAeCeKqn1JnrTouFfarR//wuCmbHoWsqfFszXoRXCmY3NXzJyahE
         K7iUHY9hVmN8w+ApJ80tW5bFz8ehe6O+BU6CtdnzboSgi2ZwLQbv2TQPoPmXhNl9g8mZ
         1JO0VHKEr0n7MLENjPiMFg6Hz8KDhE2jhYtROsUaBFTgzm3/k+v5V1IZQIHBSfGzNVt9
         sGnOLScII6bR2SOxcVj4n+Ibwv/kn3DH3CnNMp9tc5fDs1Ccw2UPVHERKIvaQ9rdj/Ku
         QDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727748232; x=1728353032;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2XJ1eZ28xIo+GDgkaOimxZFzT7dJYCNXgTF8/d60Ik=;
        b=oxmlSH4XCkNKOm/UrX8fH+/jvXEkehhkR2/v1SWK8hw8Q6biaPQ37BaElSAaN0DOyb
         aHqpGEG5R4wzE6j3BiWsOaP9n0c6rkF5JBdZGoOgu+7o5CAdSgaBDEEu1Evheu0QLbP5
         58laDAkbOF0UCr4KVglkF48XJ7LO0h6yLuLajPeGivsH7DtPZQLcnJ59O9FtKDHeyvpS
         Sbc0JM5DymgMZblU+tYwaEL0qbUei4k7nsxhsDGBfT8iWd6dQ/sFlKIb05jhVfJiriFh
         uqV9bETGicOSQIUKD2ODSXc9tEnVFzy47YebIJhj1lSgSMJJs81ESG+EorW/WVdnbjNP
         sVpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJkAoGYCt+XBq2DCplrU+IGeUQYHtRjChMv5IQiuO8LTPt2oBWxvCf20y4ZQ6TTP2EP+sLeYT5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2p7jvKjA89tLhzCdAzEQh9K3AkcFSBezAm6oLNtoXoIR+PknJ
	2Ck6SkxM5gwFba9L8lOiKYM/54vECTVzI0pTecPQZj/O++moIBbE9P1Et73jaJw=
X-Google-Smtp-Source: AGHT+IGrbVaEv02BAaGNjuWgSQHZ5Y9jc5QV9rWk1a63acmiVYjx9DCoIKIhFPNAa6nFmMy8Y++cZg==
X-Received: by 2002:adf:fe05:0:b0:374:c33d:377d with SMTP id ffacd0b85a97d-37cf28d67b7mr631698f8f.28.1727748231557;
        Mon, 30 Sep 2024 19:03:51 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e38ccfsm60115475ad.200.2024.09.30.19.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 19:03:50 -0700 (PDT)
Message-ID: <54f0bbef-267b-48d9-ae09-0f3907d4fdc3@suse.com>
Date: Tue, 1 Oct 2024 11:33:44 +0930
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
 <08ccb40d-6261-4757-957d-537d295d2cf5@suse.com>
 <7jmtrebounxuu44qgmc2y52bqlqdyuko7zp53p6iz6rkzmzzqg@m2csfnfbmv6c>
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
In-Reply-To: <7jmtrebounxuu44qgmc2y52bqlqdyuko7zp53p6iz6rkzmzzqg@m2csfnfbmv6c>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/1 11:07, Shakeel Butt 写道:
> On Tue, Oct 01, 2024 at 07:30:38AM GMT, Qu Wenruo wrote:
[...]
>>
>> Although btrfs has error handling already for all the possible ENOMEMs,
>> hitting ENOMEMs for metadata may still be a big problem, thus all my
>> previous attempt to remove NOFAIL flag all got rejected.
> 
> __GFP_NOFAIL for memcg charging is reasonable in many scenarios. Memcg
> oom-killer is enabled for __GFP_NOFAIL and going over limit and getting
> oom-killed is totally reasonable. Orthogonal to the discussion though.
> 
>>
>>>
>>> 2. What the normal overhead of these metadata in real world production
>>> environment? I see 4 to 32 bytes per 4k but what's the most used one and
>>> does it depend on the data of 4k or something else?
>>
>> What did you mean by the "overhead" part? Did you mean the checksum?
>>
> 
> To me this metadata is overhead, so yes checksum is something not the
> actual data stored on the storage.

Oh, by "metadata" it means everything not data.

It includes all the info like directory layout, file layout, data 
checksum and all the other needed info to represent a btrfs.

> 
>> If so, there is none, because btrfs store metadata checksum inside the tree
>> block (thus the page cache).
>> The first 32 bytes of a tree block are always reserved for metadata
>> checksum.
>>
>> The tree block size depends on the mkfs time option nodesize, is 16K by
>> default, and that's the most common value.
> 
> Sorry I am not very familiar with btrfs. What is tree block?

A tree block of btrfs is a fixed block, containing metadata (aka, 
everything other than the data), organized in a B-tree structure.

A tree block can be a node, containing the pointers to the next level 
nodes/leaves.
Or a leave, contains the key and the extra info bound to that key.

And btrfs uses the same tree block structure for all different kind of 
info.

E.g. an inode is stored with (<ino> INODE_ITEM 0) as the key, with a 
btrfs_inode_item structure as the extra data bound to that key.

And a file extent is stored with (<ino> EXTENT_DATA <file pos>) as the 
key, with a btrfs_file_extent_item structure bound to that key.

> 
>>
>>>
>>> 3. Most probably multiple metadata values are colocated on a single 4k
>>> page of the btrfs page cache even though the corresponding page cache
>>> might be charged to different cgroups. Is that correct?
>>
>> Not always a single 4K page, it depends on the nodesize, which is 16K by
>> default.
>>
>> Otherwise yes, the metadata page cache can be charged to different cgroup,
>> depending on the caller's context.
>> And we do not want to charge the metadata page cache to the caller's cgroup,
>> since it's really a shared resource and the caller has no way to directly
>> accessing the page cache.
>>
>> Not charging the metadata page cache will align btrfs more to the ext4/xfs,
>> which all uses regular page allocation without attaching to a filemap.
>>
> 
> Can you point me to ext4/xfs code where they are allocating uncharged
> memory for their metadata?

For xfs, it's inside fs/xfs/xfs_buf.c.
E.g. xfs_buf_alloc_pages(), which goes with kzalloc() to allocate needed 
pages.

For ext4 it's using buffer header, which is I'm not familiar at all.
But it looks like the bh folios are from the block device mapping, which 
may still be charged by cgroup.

Thanks,
Qu

> 
>>>
>>> 4. What is stopping us to use reclaimable slab cache for this metadata?
>>
>> Josef has tried this before, the attempt failed on the shrinker part, and
>> partly due to the size.
>>
>> Btrfs has very large metadata compared to all other fses, not only due to
>> the COW nature and a larger tree block size (16K by default), but also the
>> extra data checksum (4 bytes per 4K by default, 32 bytes per 4K maximum).
>>
>> On a real world system, the metadata itself can easily go hundreds of GiBs,
>> thus a shrinker is definitely needed.
> 
> This amount of uncharged memory is concerning which becomes part of
> system overhead and may impact the schedulable memory for the datacenter
> environment.
> 
> Overall the code seems fine and no pushback from me if btrfs maintainers
> are ok with this. I think btrfs should move to slab+shrinker based
> solution for this metadata unless there is deep technical reason not to.
> 
> thanks,
> Shakeel


