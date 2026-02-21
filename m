Return-Path: <cgroups+bounces-14087-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHU4JTp7mWlKUQMAu9opvQ
	(envelope-from <cgroups+bounces-14087-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 10:30:34 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0BA16C7E2
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 10:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E701300B05E
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AC424C676;
	Sat, 21 Feb 2026 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg1+qpE2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E707CA6F
	for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771666229; cv=pass; b=YwPNncw+llUco0DoOe7jF/kET39059IlvnY8yxLvbEtqZKETPiGIwWV4v7AAHbcmf6A/prw+xEGxweq2ikLHrCbIS5wIKGRLA8N0ci6j9qw6hSHV0OAt1puLxia3cymrcV0+hZ2e7KiQNfPPU67Km4LzJUDaN7cRz0N9jt0PTa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771666229; c=relaxed/simple;
	bh=M81xmkQWiQUlXZ1WyYcl3JVgILu8W7ydAuRiET6nYbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZRrPkCaumrtixUzvElteh2j5HCScNfJplrQBJ1Ts+7CdvgKU6N3QFGHWex2OlQNlZiwpxAgDrVHXfbTsV/RLRwkqlXUig1AwnCHWp3XMqPAeGH4OkFrNrbG/8lionnNs5yoHVIrz9CQO5A/nOycRdzD3clisiXdlpCf9EaJetc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg1+qpE2; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89549b2f538so21460986d6.2
        for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 01:30:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771666227; cv=none;
        d=google.com; s=arc-20240605;
        b=bU7B7bkpENCmiCAiqfuK628qcdJKvldB1JdV4cOikowFF821iUPQG/fg8ChFiIMasB
         L13L+EEqF+SkplSau6lJPzTDWxNnl+zz0A4Cf04DtNy30iauSnd+qwWDIJL4yBXMkUSm
         PM3btOUGlGGWIUVQnpCYf39AqhdICkl+QfPeVh1fhgLF3TVzVwZgQeOqEBDYWARsFUuO
         DenkH82Yuex6FRzdCB5MkZJsI1+Cf15azyp3R0NVNfVjXp91Gd+fziMfuuSur+jKwPJK
         O7HRd6+v3IKaa2heH5qqXhFjswZg3GsHBrKHywqQEHCbKiX8ncAy8SEIPP03SchPd+xW
         JPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nSs1kiH4UgjbK6XO+/po2020yekHGxUvh25+4x+p9MY=;
        fh=DCbk127pYrvNpU8a6L5p0LDQ3lr00nyuCSFPLBxAl3w=;
        b=C3c+ZuqmoJsJUHnZ7fBW94/OiLwA9QmrpWEue2S2wUO5xqex0FhMKS0m63ADDqJ71o
         0Ltujj4/aP5CVvlE88CPaXatrKwEbBKWUFW15D5vLgE5A55B+iJ5jMogmXHC9Lcoq8Di
         ImN86Y4M4qTb5icglFLCxUqMRaVOC2NoguA7UoQiznBZD5J5y67/3lLjm5n/dtq1DCuG
         ZCH1o9Ew1gEye9UJw+I7PIPMIgVZ96DiSyRU9gFvQUhTatUcA+fKSuMGNxXv3ChCns2N
         XYICDbeWyAjCvGLESCsT2Bo65hibxB46Dhyod86jRQhKej94QUkX64hs8wFJGZgaiTJ5
         R6Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771666227; x=1772271027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSs1kiH4UgjbK6XO+/po2020yekHGxUvh25+4x+p9MY=;
        b=dg1+qpE22HT/tB9NqSEXe05ncecw0PQ8JYCrA3q0rUx5UrFsPFCIGnxOvIygg7SOUD
         3AVECAEssFrCjJOkRQhMKgXy3196ndfaaITzHADXBpD5aCqG/zP4TT5puhWHI4bKAkl+
         3Yk8qAk9tNd2VltJJi471ixYQMcwanDqHlfP1GPnlMobjNidU1O2oizMjSavJdVBsgVo
         f6mbufn6Vu3EcOvRM1rna8xui0xBJf+QfhacqYo3JsYK2hGfX5gbBIpKxDL3knWMyUN6
         qO1jZCOIxn03dvwCA63TcPiCaVtx62VaNIRCTXRDTneDhh4D6vAgogIS0Zl8c3tpjFDR
         hk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771666227; x=1772271027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nSs1kiH4UgjbK6XO+/po2020yekHGxUvh25+4x+p9MY=;
        b=rnmMLea2JC4k2wCGSrTmvW/y3/hwH8HrT+4VZz8ks5O8tBEfhcsUMIrsh9jtZRVmxJ
         vVP3ZyxSWreQJ3h3ehb87fBfqF13ZSqQ/uJkbinS4OjNWfStRgIG/lMvFhc9htmL0uAa
         ZA1jPK7EwSorTrjpDFSplUeU+nG+C4xrbHxS1s6FOfYMDAToWCXY9HQqDQU8rNPEsIb7
         K/S9gkAuhtkk9uSigynh21M1JRy5MevfRDNXIboaCAqgSi42L/PXUg6P2sOQ2O9uU2Em
         +Vtv5cIrGxnWnRqf8k5AMsAaoNS0amswZTL4CNp0nYfHCQT6heeiKqa2T+8ukoQAa23E
         eb1g==
X-Forwarded-Encrypted: i=1; AJvYcCUVQVKSwcL/m1R/UZcVTbPTuYuQBWQ+1jrvDYrWjXZD+q3Q9AiMtwJry6nAZZrmrS30smNozf6P@vger.kernel.org
X-Gm-Message-State: AOJu0YyusFFRgrnMO9na17Ac93xh9zTSqILHDiMkxjBV1jaDZTFfno9Q
	UoMpD7OwDEK1/PiU8m9c+IJ2J6LrqL9cTgtukWrm8ysFmDC61PztjtwIHzN/L8EahBJGl99sYom
	cXpE5HxRA8kMvqrL/ErmJwy6FatWFI3k=
X-Gm-Gg: AZuq6aJehA1T7Q3LWnfpQie/lO4VG8r6AR9s8+vWHJX2CmZ4RsemOPLCehV9eK28mMi
	7W6WGhhGyIcoA3uziuc7W/kwDtVx6eeERcADuV4g6hjh0F/SuZqeRyJbmPysPpqsIOAh0Gq1uHC
	UPkJ3iEZ2jVMntrqcZElGNbLnksy28yZniBQVWNmQ+MJAMtdBkFrpSTJ02Yi8nl4NRrF5V2efiQ
	dGKtjm3nY+8FRkc5jF8JQ++HD1aim6hyMgJ0d7rIjBbhQ71gNuAAmNHiDuG5ZUPEEdsvWiz4Q5D
	8nxqQw==
X-Received: by 2002:a05:6214:27c6:b0:895:54f:d8d with SMTP id
 6a1803df08f44-89979c55838mr38346736d6.12.1771666227043; Sat, 21 Feb 2026
 01:30:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
 <CAGsJ_4xF5sK8H1RsqRNoi7DfGBtThASsozY30gq_kdRLaYgaTw@mail.gmail.com> <CAMgjq7CXgGxhtU3XJYnxVQ8fFYtNZBN3uF4FgqbBVV75ohOhtg@mail.gmail.com>
In-Reply-To: <CAMgjq7CXgGxhtU3XJYnxVQ8fFYtNZBN3uF4FgqbBVV75ohOhtg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 21 Feb 2026 17:30:15 +0800
X-Gm-Features: AaiRm50VzHuZ3t2BF9KIHE7v476R9sPS41fw5BuYxm6USO1DUS_s-bOs-YtbGr8
Message-ID: <CAGsJ_4zewviHRYcDVe5RSDKR5XyRppLj=7BN4dyyCCGDTKhD1A@mail.gmail.com>
Subject: Re: [PATCH RFC 00/15] mm, swap: swap table phase IV with dynamic
 ghost swapfile
To: Kairui Song <ryncsn@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14087-lists,cgroups=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[21cnbao@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: CA0BA16C7E2
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 5:07=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Sat, Feb 21, 2026 at 4:16=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Fri, Feb 20, 2026 at 7:42=E2=80=AFAM Kairui Song via B4 Relay
> > <devnull+kasong.tencent.com@kernel.org> wrote:
> >
> > To be honest, I really dislike the name "ghost." I would
> > prefer something that reflects its actual functionality.
> > "Ghost" does not describe what it does and feels rather
> > arbitrary.
>
> Hi Barry,
>
> That can be easily changed by "search and replace", I just kept the
> name since patch 13 is directly from Chris and I just didn't change
> it.
>
> >
> > I suggest retiring the name "ghost" and replacing it with
> > something more appropriate. "vswap" could be a good option,
>
> That looks good to me too, you can also check the slide from LSFMM
> last year page 23 to see how I imaged thing would workout at that
> time:
> https://drive.google.com/file/d/1_QKlXErUkQ-TXmJJy79fJoLPui9TGK1S/view
>
> The actual layout will be a bit different from that slide, since the
> redirect entry will be in the lower devices, the virtual device will
> have an extra virtual table to hold its redirect entry. But still I'm
> glad that plain swap still has zero overhead so ZRAM or high
> performance NVME is still good.
>
> > > Currently, the dynamic ghost files are just reported as ordinary swap=
 files
> > > in /proc/swaps and we can have multiple ones, so users will have a fu=
ll
> > > view of what's going on. This is a very easy-to-change design decisio=
n.
> > > I'm open to ideas about how we should present this to users. e.g., Hi=
ding
> > > it will make it more "virtual", but I don't think that's a good idea.
> >
> > Even if it remains visible in /proc/swaps, I would rather
> > not represent it as a real file in any filesystem. Putting
> > a "ghost" swapfile on something like ext4 seems unnatural.
>
> How do you think about this? Here is the output after this sereis:
> # swapon
> NAME           TYPE       SIZE USED PRIO
> /dev/ghostswap ghost     11.5G 821M   -1
> /dev/ram0      partition 1024G 9.9M   -1
> /dev/vdb2      partition    2G 112K   -1

I=E2=80=99d rather have a =E2=80=9Cvirtual=E2=80=9D block device, /dev/xswa=
p, with
its size displayed as 11.5G via `ls -l filename`. This is
also more natural than relying on a cdev placeholder.

If

>
> Or we can rename it to:
> # swapon
> NAME           TYPE       SIZE USED PRIO
> /dev/xswap     xswap     11.5G 821M   -1
> /dev/ram0      partition 1024G 9.9M   -1
> /dev/vdb2      partition    2G 112K   -1
>
> swapon /dev/xswap will enable this layer (for now I just hardcoded it
> to be 8 times the size of total ram). swapoff /dev/xswap disables it.
> We can also change the priority.
>
> We can also hide it.
>
> > > And for easier testing, I added a /dev/ghostswap in this RFC. `swapon
> > > /dev/ghostswap` enables that. Without swapon /dev/ghostswap, any exis=
ting
> > > users, including ZRAM, won't observe any change.
> >
> > /dev/ghostswap is assumed to be a virtual block device or
> > something similar? If it is a block device, how is its size
> > related to si->size?
>
> It's not a real device, just a placeholder to make swapon usable
> without any modification for easier testing (some user space
> implementation doesn't work well with dummy header). And it has
> nothing to do with the si->size.

I understand it is a placeholder for swap, but if it appears
as /dev/ghostfile, users browsing /dev/ will see it as a
real cdev. A /dev/chardev is intended for user read/write
access.
Also, udev rules can act on an exported cdev. This couples
us with a lot of userspace behavior.

>
> >
> > Looking at [PATCH RFC 14/15] mm, swap: add a special device
> > for ghost swap setup, it appears to be a character device.
> > This feels very odd to me. I=E2=80=99m not in favor of coupling the
> > ghost swapfile with a memdev character device.
> > A cdev should be a true character device.
>
> No coupling at all, it's just a place holder so swapon (the syscall)
> knows it's a virtual device, which is just an alternative to the dummy
> header approach from Chris, so people can test it easier.

Using a cdev as a placeholder has introduced behavioral
coupling. For swap, it serves as a placeholder; for anything
outside swap, it behaves as a regular cdev.

>
> The si->size is just a number and any value can be given. I just
> haven't decided how we should pass the number to the kernel or just
> make it dynamic: e.g. set it to total ram size and increase by 2M
> every time a new cluster is used.

