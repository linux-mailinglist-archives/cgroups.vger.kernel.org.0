Return-Path: <cgroups+bounces-14086-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM6ELOR1mWmmUAMAu9opvQ
	(envelope-from <cgroups+bounces-14086-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 10:07:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5CE16C780
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 10:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87B0C3005989
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11749314D07;
	Sat, 21 Feb 2026 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyWc3vI3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904E5BA34
	for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771664863; cv=pass; b=qnVu2WqyD3h+qtgoOZ/OSAKtjpH3us7EFwEIOwoctof2TTBZHp0zyJ4GnBdCWVoO2M6HBQta9su0vXEcVwiwOTeHnaI6yGodP1CxD+h38LU5XRG7vQiM4ltEzMEOGajx8Hvf30CoRc34QM6aJl4FDY4sodV6Tx40EOsolpXNEPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771664863; c=relaxed/simple;
	bh=bZfYC2mhs0rW0TlsypPJerp2aS44IX/URkrjBiqXwtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQxGdhlqR6pyJdfw11Yo9hr+yWIe1qF7mfMvVSUAqkXXK3H3W4mpht6vtofQhf6+fKKtWuAiuWoGrNb9gHFVHKSkdi8ihYwiAeKoGqdhKtXWG72Gk6P1Wr1HnZ2Nx264kaB+1MNxhvcrSN9TTwNxLZaWWJ29yz4wZL+yyh+7XqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyWc3vI3; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so4807862a12.1
        for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 01:07:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771664861; cv=none;
        d=google.com; s=arc-20240605;
        b=DTmoSvl3NRNexKiRPktAr5DavI/VvVUGWl5cigPIEINVDv+dWSfrpshOxInqAPBMYl
         i1B2YOVHPhxkikYBNKiMiyKlfpHzYsOITA/6ybYAXvy7CJ+1bQlZvetTFthRXMETYA8i
         gcxB1tPRApKrmMQsKm5CuuOn8ci+LpQt0/2qceg/V77QBh9Q+CWMtDd43C1OOZGQeINW
         uX5fVumQCDSS6lTgEZzk6BL55whyKjSJm1i24p5s+jZ2VoQHlU62tMEset3Jfj5WBh0n
         u+qn9bZ1KYyIXdmcnm5X64u/K1dz6fO2HwrEzoOrwyGzFqy7/y4WrGqf/BavRcn7wS6q
         dPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7mpDa+Cf0rkXthtuWh2Ox5sMJPbVs/hniYk2Xcoitzc=;
        fh=oxONXqsCxXNnlqc2WmoY36jQpga6uY8W8FzxatFBzAE=;
        b=X9ILNX6ThfcfkLvLCUDqWXC0p6J/TQQV2noTBQK4mZGmC/ADYWgVN5xtuq0X60H/D6
         Ms2i/0UrnRK9P3GzWlcOXmchSqzOjCbaHKyVocSQfsBMX5R/PRot+BuNh0uMaUm5KPvM
         Ix2OgRVwq3p+i7u3d9zW/NPO0NYe5Fvp+zyD/SVv4sIu38QTUCzG6UwNcrNtB6L3rn0+
         j+Jc03boDlerW88tOhEzaJ/RdFVkdpYKZdt121gqG2Ts3lZDeZ1PGbIL6fNk2ShnowSM
         ZN1aCTf4qTcZIl7VFX7JwkyY4yxHqiHWm9qo/FDRflAv8U5w+WyOpdKwgP+7j7Hs3/pt
         TJ8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771664861; x=1772269661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mpDa+Cf0rkXthtuWh2Ox5sMJPbVs/hniYk2Xcoitzc=;
        b=WyWc3vI3i17DU7MOrJqpzVR/2Jo8k3ru76duv7UlKFAw3wItYEH4mjANqyZfzEJWuD
         VJw4bKjxgDkOVPQ5opWGKhWPJnZVaGGqUsyXwhTHmAoGO5GgvyKMQBAqb5MB1gxFh79/
         1AIuio56FD4cyEx86fJ5yLjOVYUGkfTfglOTRtNNCE5djTW/pnrxSFs+lz1qC3T1LJz+
         Ae4czrsfoAo1B9ymEohh15pe+GJAPQRtlIVarRbMeiij78IB5QRn75ltRwRTUAD32irS
         iSiVHewAqY2hSrmE4H97PW7LPsr+Fts0qFnLX/OdLhJimkv5a5MABEAmexGbz3rDEeNL
         o2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771664861; x=1772269661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7mpDa+Cf0rkXthtuWh2Ox5sMJPbVs/hniYk2Xcoitzc=;
        b=dBPbr/goSA/63swNfH/J0ulzcVnfgPs6M1OgZEFX9plwAlYn+b4+5idlVWHMrtldun
         WLHZsvBJAW4IuCPUSjK+Ad0IaCbYnUwLlc3Dh6Ra/joiPJvnSeO4ZT97EOWHNbV/lS9f
         ClIh1fXTlyfkmpZoEUZMKKiEbcj6j1ewcZepbsDVOt76rt24dlVi8eJ383BpuHeYg3Xb
         MngrwYWujNqAzQzCLm08TtT5KbjHaSqhHycDhSgOw3ulEl1Wm1U9sWk7blfQDdKHl0Pb
         FO1kRS8VqPOhLjB3MJB6nRGRSpHe9gXNSiN8xgy9o/9VpkBm+PyDa+UC8Ckyya6BJ5lZ
         VvKw==
X-Forwarded-Encrypted: i=1; AJvYcCUvP6apPQ6eD8gkgb8Qb7ttGZBWoE7fjYC19ViDNC8zCClzSCE9n4fFKJKG+F2G9hx3gJCEt40+@vger.kernel.org
X-Gm-Message-State: AOJu0YxXXW/xxPvpQ71fhWAMer272wRkg7lH6dB3sm3/4xDJ4VP25kJz
	wHATiiLGP5QSxFXh8jVNi9HHox1S5U4hW9DzlMKUBZiYE/y+zcxaVxN75qIia8IQpji+DUl8j2+
	Ip8U3TwuHgUXw+RkFLZ/1UTOwKS2UjgQ=
X-Gm-Gg: AZuq6aKhKLL8ml3p1rVg6pA/OgWqtB6vhV8I3U67rWL0JjVfHUbA5/4VWpH9ntKJud9
	mio8T4JVauaS8yr222QEjSVnjAn9SDQCsZ/Pzh5MNCRfuXSNhhm3F04jTo0xbnBxIislBYDCQ3a
	WdZQ6CIE2dKtho1kSXAVjiXcRVvgbjemoS9Jel+yUYx9RfuXHRu/lRHXaLii26IVssTQ9rRGfoa
	+PyojnNKkTPOboCEBU2InBdUlhAQBEZOiha7GZYDt5Wtk5ArAqXuadQtoZ0y5ByJT0QEHWOW5k4
	OyoZJQISWHVEQD//WcZj09cO3xsyaUj13GUZ6p5E
X-Received: by 2002:a17:907:3d12:b0:b86:ecfe:b3d with SMTP id
 a640c23a62f3a-b9081b22197mr153494466b.43.1771664859427; Sat, 21 Feb 2026
 01:07:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com> <CAGsJ_4xF5sK8H1RsqRNoi7DfGBtThASsozY30gq_kdRLaYgaTw@mail.gmail.com>
In-Reply-To: <CAGsJ_4xF5sK8H1RsqRNoi7DfGBtThASsozY30gq_kdRLaYgaTw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 21 Feb 2026 17:07:03 +0800
X-Gm-Features: AaiRm50ZxftWTS5gtnKtLyAzl5fZtzb6QE6tzQJ7BId14uLxR96r9FuZkjUn9z4
Message-ID: <CAMgjq7CXgGxhtU3XJYnxVQ8fFYtNZBN3uF4FgqbBVV75ohOhtg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/15] mm, swap: swap table phase IV with dynamic
 ghost swapfile
To: Barry Song <21cnbao@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14086-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,oracle.com,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,lge.com,bytedance.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4E5CE16C780
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 4:16=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Fri, Feb 20, 2026 at 7:42=E2=80=AFAM Kairui Song via B4 Relay
> <devnull+kasong.tencent.com@kernel.org> wrote:
>
> To be honest, I really dislike the name "ghost." I would
> prefer something that reflects its actual functionality.
> "Ghost" does not describe what it does and feels rather
> arbitrary.

Hi Barry,

That can be easily changed by "search and replace", I just kept the
name since patch 13 is directly from Chris and I just didn't change
it.

>
> I suggest retiring the name "ghost" and replacing it with
> something more appropriate. "vswap" could be a good option,

That looks good to me too, you can also check the slide from LSFMM
last year page 23 to see how I imaged thing would workout at that
time:
https://drive.google.com/file/d/1_QKlXErUkQ-TXmJJy79fJoLPui9TGK1S/view

The actual layout will be a bit different from that slide, since the
redirect entry will be in the lower devices, the virtual device will
have an extra virtual table to hold its redirect entry. But still I'm
glad that plain swap still has zero overhead so ZRAM or high
performance NVME is still good.

> > Currently, the dynamic ghost files are just reported as ordinary swap f=
iles
> > in /proc/swaps and we can have multiple ones, so users will have a full
> > view of what's going on. This is a very easy-to-change design decision.
> > I'm open to ideas about how we should present this to users. e.g., Hidi=
ng
> > it will make it more "virtual", but I don't think that's a good idea.
>
> Even if it remains visible in /proc/swaps, I would rather
> not represent it as a real file in any filesystem. Putting
> a "ghost" swapfile on something like ext4 seems unnatural.

How do you think about this? Here is the output after this sereis:
# swapon
NAME           TYPE       SIZE USED PRIO
/dev/ghostswap ghost     11.5G 821M   -1
/dev/ram0      partition 1024G 9.9M   -1
/dev/vdb2      partition    2G 112K   -1

Or we can rename it to:
# swapon
NAME           TYPE       SIZE USED PRIO
/dev/xswap     xswap     11.5G 821M   -1
/dev/ram0      partition 1024G 9.9M   -1
/dev/vdb2      partition    2G 112K   -1

swapon /dev/xswap will enable this layer (for now I just hardcoded it
to be 8 times the size of total ram). swapoff /dev/xswap disables it.
We can also change the priority.

We can also hide it.

> > And for easier testing, I added a /dev/ghostswap in this RFC. `swapon
> > /dev/ghostswap` enables that. Without swapon /dev/ghostswap, any existi=
ng
> > users, including ZRAM, won't observe any change.
>
> /dev/ghostswap is assumed to be a virtual block device or
> something similar? If it is a block device, how is its size
> related to si->size?

It's not a real device, just a placeholder to make swapon usable
without any modification for easier testing (some user space
implementation doesn't work well with dummy header). And it has
nothing to do with the si->size.

>
> Looking at [PATCH RFC 14/15] mm, swap: add a special device
> for ghost swap setup, it appears to be a character device.
> This feels very odd to me. I=E2=80=99m not in favor of coupling the
> ghost swapfile with a memdev character device.
> A cdev should be a true character device.

No coupling at all, it's just a place holder so swapon (the syscall)
knows it's a virtual device, which is just an alternative to the dummy
header approach from Chris, so people can test it easier.

The si->size is just a number and any value can be given. I just
haven't decided how we should pass the number to the kernel or just
make it dynamic: e.g. set it to total ram size and increase by 2M
every time a new cluster is used.

