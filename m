Return-Path: <cgroups+bounces-4018-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931A994233B
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 01:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C451B1C22826
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 23:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F14818EFF4;
	Tue, 30 Jul 2024 23:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfNL0jv/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B372C18A6CE;
	Tue, 30 Jul 2024 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722380786; cv=none; b=s2uk6sMMkvqQWWApvki0hzpLM+a3UfjyKtcy/GCrs4QBimR80H8vauxaJDXzKZm791p74VnXRPLa2+IXArjUAxBTcTZajvsOkjupZMr/srU/HOYqyInVDb7JHDbCDnuPdl6s2oBN8OXptv/BK7kIEoyYDcIGbqr8XRyakbbIHFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722380786; c=relaxed/simple;
	bh=Op69JpkQbbxme1B12cNzAavcMe2Pz6PcH+hqgtsgECw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OY2+0yKj78osMbu/sron//b7HLyX3FEspftv4C1zlzZ6G1MRFeJy1hmhP8mKZT11iBdMbnxdosV+FFFpKdcZHhpDhu3wEGje5klnid59JDY0xaHGLXdXhPbE8DdEiNY8cQyMOZErb2sQTRewLhMfcHGT2ZuW25Qn/OBKwGhgZKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfNL0jv/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fdd6d81812so41389115ad.1;
        Tue, 30 Jul 2024 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722380784; x=1722985584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6lB3zfnMbEB0fLiWI7+IIRHRj4kgKjTW/X0L+tCnBY=;
        b=FfNL0jv/pERUTffIg7mykpbs8YFGyP5XnwvH+LajCiXyQgiThR+JzfjOY0Oeaig0TJ
         3vnVmGnqRuAju97qC/C9P3dCaSStxP3UHmG9hr5JN5UmtTJFpWXV+DwdzdjnXVabajif
         Y32VPu8AS1xoa0r0LFQNh3ytxZz70MrT2uJbE8RDKrk5MSKcv/5M6jhhZaOgvVwxTGQs
         w0YtPlS63i1tprD5BKXtnx9MpsZkz2JL/z9HwhlUcxvdDa9xq9t3ZRC+pEFJJ608p4mF
         MAKRNcDAObIUTg4QwwF/qAB4djfFFlbOGSOyoJt1Uu8xLM8Gl3cBGzBB1HX5R4LRhesL
         ytBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722380784; x=1722985584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6lB3zfnMbEB0fLiWI7+IIRHRj4kgKjTW/X0L+tCnBY=;
        b=ub19sUMX3DqI5fDVxPu7uY+dnEj22Zhkl/S6QmzeRjHyFpoTpMmugX2Ww06/PDTnv4
         k2JBpB3ZXzQgfmzAjW+pvk6BI2EsUxac63c9bE0n63ryMg6M0uuPvbfd0Jl+026mG5kt
         ikKeSRiu/kaRgMp7+4ELik5i5F2v5WQ25zBIWUNjjIIilzWcIsMK2V7CVy/+zln2KxXU
         6pDJUdHz2X36BSKfaUe2Yna5/D8BWEGj7KnLw2jpEsQdkZZQ4q38sKniif38C12IBH7c
         WM+OEoRnpgqILXAyAZYwca/yJ/2scQ0BDPzCg77pzEh2zqnzmIjMQCHSUebR7+Lih3GO
         zBTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQIjdO9nPx9VCYrF+yQqMl+toDMKjRS9qQb9aRi3xZp6KodimeF8IRuRU/XDCrKTakc1kPpl96V2GFkylhkevUmgGqZVcLv3dwAxkFwZ4LmLTw5e9IeASARQMsTaEw8BijxHJjHQ==
X-Gm-Message-State: AOJu0YyRJxTnsql9SaX53ZLpcR1HXjWAru90szYjHOKuTmfjxpFVFnVf
	KQGKHwANNb6OwIZsr6v3W5EqyngARYZhQRk6P3hjQened178kNEt
X-Google-Smtp-Source: AGHT+IGcMNK/qfM/GFq6voKuNe58wyU1uRMv7LMAUZsaKck7J8HvPBr5zu6ho22w115CMemADOXQbA==
X-Received: by 2002:a17:903:7cc:b0:1fc:5f3a:4d9a with SMTP id d9443c01a7336-1ff0491ac2cmr130268935ad.58.1722380783867;
        Tue, 30 Jul 2024 16:06:23 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d37b9asm107607185ad.114.2024.07.30.16.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 16:06:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 13:06:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Xavier <xavier_qy@163.com>
Cc: Waiman Long <longman@redhat.com>, akpm@linux-foundation.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, mkoutny@suse.com
Subject: Re: Re: [PATCH-cpuset v11 0/2] Add Union-Find and use it to optimize
 cpuset
Message-ID: <Zqlx7gY2PnDPLj1R@slm.duckdns.org>
References: <f9e55eb8-82a8-45f2-a949-1db182e95fc8@redhat.com>
 <20240704062444.262211-1-xavier_qy@163.com>
 <e20fe0dc-a3ef-4f55-a991-6efe1a9ddecd@redhat.com>
 <ZowyKf3RlMI0q1P-@slm.duckdns.org>
 <5c90d42c.2c03.190fc5fb1c8.Coremail.xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c90d42c.2c03.190fc5fb1c8.Coremail.xavier_qy@163.com>

Hello,

On Mon, Jul 29, 2024 at 10:44:08AM +0800, Xavier wrote:
> I saw on kernel.org that v6.11-rc1 has been released. It might be time to start merging
> this patch. 

Merged two patches.

> By the way,  I have submitted an optimization patch for RT group scheduling, but after
> two rounds of communication, I haven't received any further responses. Could you
> provide me with some advice?
> 
> https://lore.kernel.org/all/20240627172156.235421-1-xavier_qy@163.com/

I'm not sure I have a useful advice other than just pinging again.

Thanks.

-- 
tejun

