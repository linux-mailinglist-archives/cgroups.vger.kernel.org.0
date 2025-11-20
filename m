Return-Path: <cgroups+bounces-12135-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB67C74AA7
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 15:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id BFB982B61E
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B271345CB9;
	Thu, 20 Nov 2025 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Nlop4bDN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D333F396
	for <cgroups@vger.kernel.org>; Thu, 20 Nov 2025 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650371; cv=none; b=rR4pnJezd4u2N6vUkjYpPD2zhjoSOryui7cDVxpA9+1jje9EgmT4c2BxyMxQsocAEx20rJabX26rf2KW7ZnHeLCS6/VKdieOeWMoQX5KO6c82mktuU5Qcf28bY+dleT/gQf9Hn0EPUVmRAyP6gIcgh2hrFt+IQjM9JFBryAEBQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650371; c=relaxed/simple;
	bh=fJNbQYu7PoiJLsEPpjUYNqAPI6k2geFEJacIKnsv5a4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TXEbB1eUVH8L+Wqj3NukzdLW62EdATs19OO06AS62AA7UzWjrBUAwca31HpTr8qEllkXGun+KRTffmPkcgcE/3ElBggV2ebDTP2vsvad/oXCRyUXDN/AIZmFPOizXnNV6w+jcChXuRoF26+mckDfLcYpa+hV6Z6edCSo+JVsMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Nlop4bDN; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-43379251ff9so9582705ab.1
        for <cgroups@vger.kernel.org>; Thu, 20 Nov 2025 06:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763650367; x=1764255167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIp1emodWmrQX+c6TjoXmEBGWcecINECr9nK+dGHBUw=;
        b=Nlop4bDNIOkjuo0pMhzaqc0ODrEsmRo7XtLqwhp00uyFASxw+sbIvvfDKg63/0WNIr
         Irgw7i1L5c7f3KspyZuRfY76O51HffIuodvQy5ZIcDN4No7WwIxUOGZ9dpes/M6K+nsd
         SNLzENdMcdkRpJUmuFjuM9BMlGaR61DPmsUMatu7aVJzbpi7Z/RO6GbliOgOscpBha8S
         DnzFtV5phPRpPEJgf98WlMFKyzL6CdLykV3ZnkTgBAq3ZRb9M24771+6fglXYKmcEHuj
         JwzMwrRMP1iOEu/PZF6XSo/nxjqLzdvmfaif9TGvKGR4YXIy2m1LIpokuAZvSHGS7C+s
         olCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650367; x=1764255167;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mIp1emodWmrQX+c6TjoXmEBGWcecINECr9nK+dGHBUw=;
        b=Qa8LgQZObVKlf5nQ8m8A4YhXT72Dtc2BeJuzkZTXuc3QqMt5EXp8IdBG89wzp4gAxG
         nUoXGNbr0uYuuWo9gM4n+Kd+n3JctAMiBggMTTekNhNfvFnf69CjwaFuT0MVXsEvNvny
         d6JsC5eWmRVnmpyFa/S3FwF8NZpL6Jyb4+fn5WYEaK5+1l2Baq3rzdJnnc96+pMM4vfa
         L+J1MIFB+HrRpBLZW/4ncINf+SA7oqci8ZGqguS/gY+YKT8qwS6Q+llDTxQLmo1BsQJj
         24ucDiqp4fQF6J550ALq4odhpx1D6Gc2yT5aeMvtEgQ16PeN78ls/1GF4YhVYg7mJhet
         U7NA==
X-Forwarded-Encrypted: i=1; AJvYcCUM3KxgMdhB2FxqYzAgXbtEdDMBrRltEIajDOoh+Hfq5K/YRl8GDmUxul19GR/M8Y8YMSa2CBs6@vger.kernel.org
X-Gm-Message-State: AOJu0YwyXU5BDOCUz98lQewyJtYQcVYE+YFSG+7NNKJfrouNDbdPZkFv
	+qNsx1zLnuvXGQnX+zCJgCu3CJvibQOeuwwHtlllXsaUyD8VGRYGpEDrrw9HbNZsLFQ=
X-Gm-Gg: ASbGnctVrlDlhAc2nguXvZzJUZ+nQrFqia7jWAKDxo/m3YJSjigJV+lv1xtYbLyns8U
	AUNjTgBZ3FppytQhMT9z4dbYap4VocxsiVZJ7SCYSR0NDoW00FknirJwD4fM1swfmGL/z1FHAX2
	l17ITW/rg3rM1IyvBaWDmPzmYT7RSvzPkMe8ZKBHu/A7I6ZQ5v7BbB2Hv5BUnlqwWpQZkPboS8L
	j8GRcJFE2lt0BokosgNx0mt304NWFtDyiyPhCFJikxBwENm4Cosb6iBYCC2GbQWfxUmQYps+A69
	jqDP6rj3MQADYnX+3EV0tWM2JlJcD5FcdmOMoPq43wBx/hWz/iXsDU+ezemQbDHOcFUUEpTL1PD
	41PjVGtDY7cqVjaFKm5TZy1+YA5fU9qHxoGMB0kGU3GA4Sf3vEIvlHCWrVhy4NoMsoLB7VeDJ2n
	z7Wg==
X-Google-Smtp-Source: AGHT+IEmRlVKCe07qbgo1t2w3uFpBKsqx62crTftDC+8sZ0oUBIrcGL53VTRakva//fmnWvcfQrQww==
X-Received: by 2002:a05:6e02:1c01:b0:433:1d5a:5157 with SMTP id e9e14a558f8ab-435aa88e822mr21434775ab.6.1763650367018;
        Thu, 20 Nov 2025 06:52:47 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b207d7sm1008611173.33.2025.11.20.06.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:52:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org, david.laight.linux@gmail.com
Cc: Alan Stern <stern@rowland.harvard.edu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Andrew Lunn <andrew@lunn.ch>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Christoph Hellwig <hch@lst.de>, Daniel Borkmann <daniel@iogearbox.net>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 "David S. Miller" <davem@davemloft.net>, Dennis Zhou <dennis@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Jiri Slaby <jirislaby@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 John Allen <john.allen@amd.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Juergen Gross <jgross@suse.com>, Kees Cook <kees@kernel.org>, 
 KP Singh <kpsingh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Mika Westerberg <westeri@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Miklos Szeredi <miklos@szeredi.hu>, Namhyung Kim <namhyung@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, nic_swsd@realtek.com, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 Olivia Mackall <olivia@selenic.com>, Paolo Abeni <pabeni@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Huewe <peterhuewe@gmx.de>, 
 Peter Zijlstra <peterz@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Sean Christopherson <seanjc@google.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
 Theodore Ts'o <tytso@mit.edu>, Thomas Gleixner <tglx@linutronix.de>, 
 Tom Lendacky <thomas.lendacky@amd.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, x86@kernel.org, 
 Yury Norov <yury.norov@gmail.com>, amd-gfx@lists.freedesktop.org, 
 bpf@vger.kernel.org, cgroups@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, io-uring@vger.kernel.org, 
 kvm@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-cxl@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-mm@kvack.org, 
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
 usb-storage@lists.one-eyed-alien.net, David Hildenbrand <david@kernel.org>
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Subject: Re: (subset) [PATCH 00/44] Change a lot of min_t() that might mask
 high bits
Message-Id: <176365036384.566630.2992984118137417732.b4-ty@kernel.dk>
Date: Thu, 20 Nov 2025 07:52:43 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 19 Nov 2025 22:40:56 +0000, david.laight.linux@gmail.com wrote:
> It in not uncommon for code to use min_t(uint, a, b) when one of a or b
> is 64bit and can have a value that is larger than 2^32;
> This is particularly prevelant with:
> 	uint_var = min_t(uint, uint_var, uint64_expression);
> 
> Casts to u8 and u16 are very likely to discard significant bits.
> 
> [...]

Applied, thanks!

[12/44] block: use min() instead of min_t()
        commit: 9420e720ad192c53c8d2803c5a2313b2d586adbd

Best regards,
-- 
Jens Axboe




