Return-Path: <cgroups+bounces-10754-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9B9BDBED8
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 02:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029F518A6CEF
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 00:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88ED1DE3A4;
	Wed, 15 Oct 2025 00:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvNpFVhW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB421917F1
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 00:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760489148; cv=none; b=rZwDXx5/Gd8+aPRT92eoAy7VpdQmbWG4iDteluOZjDCjjkLaPPJZNjy21wAVqHXulcpcJFr9aXChBUsGHqj1MvuAaN5MUDz3PTZjDW/MnXFnw17sE5sa2LFyZMysIjtpS9P74iM96T7gTEXK0ks6sFyQ8H8XLa2EjnwEn0oa7Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760489148; c=relaxed/simple;
	bh=QWZy/15xnGTRgPkf5Pka44YljXIi4GDc0D994BUVp4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsVDkFT1fDGuLBUnu8uGOdzwdBJ5knhSb73wA3hy1AjOBrhf7VM023JJNnWb/1ZNJQ7fx/HVVpM/3GmIAyI1H6Qjrny0uUkyvcno/BObAtIZCUIkpHHDLof4k+wgWl8+qWKDtxm1LvsVidZKn+wtif+TT7jtit8n/c8/M2efw8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvNpFVhW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e2c3b6d4cso45342845e9.3
        for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 17:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760489145; x=1761093945; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjS2vWmWFupijvTyxg2fppwPWWk6ldlFSBLrc+f8lsk=;
        b=KvNpFVhWTFELaiAqhGS7x0NZitH5f/OLep4v15djPHyrq2Aw0JK/6IzoelOW6F0GPJ
         +yRBedJHiUictgIiytF/0wNS0as6BP6LzvOLlexN4eBhOWFCtQLScIXuzOg1SuIAj96M
         mpnU6tfZXlhDxptdn3GuNYMV+o2z3XF8AFjHHhKh7TK1DEW2Z98vdeOzn4AE9vx+aNmS
         inVWfnvAl9FbiBnmAxIKq04ZcxhajQAUlE4v+al1Ix9nKCiBujpEtcZ9PQAJQ/tim5Xa
         A0tAH8udGup9ls+eP4G7sKZ6UTOLuEFmNPu72c+1W/T0AgzqaUvbow9D/b4EbOsfEo/J
         U/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760489145; x=1761093945;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JjS2vWmWFupijvTyxg2fppwPWWk6ldlFSBLrc+f8lsk=;
        b=TMALiNkbI76b+NcCy8xEl5ajKrSvd1fzeWKi6mmEdEGqHkOzpREGzuFbmPR/HI79uD
         Hq2cIBk8t1OpuB7TkRVDwTQcfQ0lyFDcjWX66GgFESuKQRgO0yao+MmEqfGEgDTuYdZS
         CIhjsZWcxHh3EZ9XwcKkf6M92Ox2OfG1xZU5SFc89UGqk1rEksMC9IoNZpbwsz9B+LQ8
         ur8NvV5FUMad61tzDJ1h5Bw+8tg/m8dBAtpKVpYPFDdlvW9k2fqRQakDSWec+9V7WHon
         RF6pV5YvzjfZ4QmRdbi/FO01keT5rYy/aCmbAq/hAp2cpNJ2LXcervCbD3Nr31iw8Dxu
         yPow==
X-Forwarded-Encrypted: i=1; AJvYcCUdwWPZF75vne+pzZZWDnRpzzbZbhxnL88TG0UoXCQTkYu65gEM9LDGnYKfdb9ChwEQgjzZHv1k@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+w1d8sgoyyXTHBz6C+QzzOdMzHMDgh5wn0HOXzgnmPNSg0ihX
	uuMC0DN4isTUOFH9+5E3qNZuW5K4giBpQiuD9CmWRLCqyMgZHX7+DoQL
X-Gm-Gg: ASbGncuN+tAzL6LOUw4nOW/bszWisqZ4z1Y/dOv/0AuCAjIowXXTkipvpDZXqUIOspi
	wvfpdrnisg/+s221Vn/EiHeOfvlwes6jMZAoshG14attSOQlTZvaVv13XF3A/IpSrKQI5KgndTd
	CpcBu4Dp+io08ZLlbN/TIz87hIesBhlTVsF/5bFsH/i+6H/ySteyXJcYnAPZhGaNAR+f3pyJx1A
	IPi2b71Vm9ow5MSxOxJG8Zc/gNGidDJMVzXt7si6LWry88wFbQhXLFsBtenYhy9hob2OJxAzjhv
	V8DL0QBNNB1kpD83d/tfXTn+u9dBqHctWamUOTiHrinr12wTg84IynFe+v3Rul/dI3d9q8Bb/FP
	kWi9tyX1skw1D/C0QRsdLnCu/uMKWK/RMqSYVfSEZ0iSMNGtv+rU=
X-Google-Smtp-Source: AGHT+IEUsuN0HzcjvOiasKjxoAVXbiNobka2YXSRTY/9Up4v1JrTdSmA4WVnfLZUCScJw93cZ5lkow==
X-Received: by 2002:a05:600d:42f2:b0:46e:4341:7302 with SMTP id 5b1f17b1804b1-46fb15396d6mr133011165e9.34.1760489144718;
        Tue, 14 Oct 2025 17:45:44 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc155143fsm220567755e9.11.2025.10.14.17.45.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Oct 2025 17:45:44 -0700 (PDT)
Date: Wed, 15 Oct 2025 00:45:43 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3 20/20] mm: stop maintaining the per-page mapcount of
 large folios (CONFIG_NO_PAGE_MAPCOUNT)
Message-ID: <20251015004543.md5x4cjtkyjzpf4b@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250303163014.1128035-1-david@redhat.com>
 <20250303163014.1128035-21-david@redhat.com>
 <20251014122335.dpyk5advbkioojnm@master>
 <71380b43-c23c-42b5-8aab-f158bb37bc75@redhat.com>
 <aO5fCT62gZZw9-wQ@casper.infradead.org>
 <f9d19f72-58f7-4694-ae18-1d944238a3e7@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9d19f72-58f7-4694-ae18-1d944238a3e7@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Oct 14, 2025 at 04:38:38PM +0200, David Hildenbrand wrote:
>On 14.10.25 16:32, Matthew Wilcox wrote:
>> On Tue, Oct 14, 2025 at 02:59:30PM +0200, David Hildenbrand wrote:
>> > > As commit 349994cf61e6 mentioned, we don't support partially mapped PUD-sized
>> > > folio yet.
>> > 
>> > We do support partially mapped PUD-sized folios I think, but not anonymous
>> > PUD-sized folios.
>> 
>> I don't think so?  The only mechanism I know of to allocate PUD-sized
>> chunks of memory is hugetlb, and that doesn't permit partial mappings.
>
>Greetings from the latest DAX rework :)

After a re-think, do you think it's better to align the behavior between
CONFIG_NO_PAGE_MAPCOUNT and CONFIG_PAGE_MAPCOUNT?

It looks we treat a PUD-sized folio partially_mapped if CONFIG_NO_PAGE_MAPCOUNT,
but !partially_mapped if CONFIG_PAGE_MAPCOUNT, if my understanding is correct.

>
>-- 
>Cheers
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

