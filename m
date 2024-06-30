Return-Path: <cgroups+bounces-3460-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7481D91D300
	for <lists+cgroups@lfdr.de>; Sun, 30 Jun 2024 19:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D9D2814EF
	for <lists+cgroups@lfdr.de>; Sun, 30 Jun 2024 17:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFB7149C7C;
	Sun, 30 Jun 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VljQIJzD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFDA282ED;
	Sun, 30 Jun 2024 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719767023; cv=none; b=aFJa9qi2BtI+LQP3eghnEJFFDl0isdZOOSF561CljeftYnPqJkbGYrUUMuHxM/oATtx4LOrbqE9/SEJ8V2yCVAIKGOAj3ISpP5jFpP7ebBlkvlUK83JLvkFwF+NdVb1ePB8TMZbC3uNr1BYkWI2XlZ297wpG2BPHpgsAK9/iFu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719767023; c=relaxed/simple;
	bh=jjOtl29A70pu8X4oM6FwG48iiDZVebDe/QwQZ12SrB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9kZAPqulzpIIym/ETOISs59oa+QtFZ2xfiqDLPgNTla6akwbl6B6RtJjixHg1Jb6eUASqpH1Ej+uwCH7Q7MtqdCkpJkLMfKx077RlM1sMwHpEi3eX3cTo9fcNvrVTPFhsQoXgrezTsW9kaYOXTMj2gF4EAK+IcvYQ9ZIj3b3x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VljQIJzD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-706683e5249so1272090b3a.2;
        Sun, 30 Jun 2024 10:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719767020; x=1720371820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5owlD5lltLvAbBD17/0DblPjtl+cJf7M5OuX1U77Xg=;
        b=VljQIJzD9ZUG2BMg5qTrrthNYv4u89uqmaZxNbyW3IY6tudxCY4erRr719M/sVgl0v
         SeydgA+hRzvbSQG67ylr5G65Cl+uJAcfyLq2NQHQmfy5/BRWG+3X7VpA4VWOqaar2/om
         1QsgWL4kcqxtL1zRxg5EQzuXFtRHRxtr1jwA0DrJY3uqkTaYlyLb5b/NPayqD9qWe9Tf
         /4DNKdOa7gwg2SqPbxuBBAGVMyC/GNXWHQrKEwi9alsmLo8jzJ6my8esNXisRx9M0y/D
         C7ZnfadC6Lzp/zZBuXo5b3fnKYByRlWHO3V5Eq2Ztul3bjcHLTBLByCjJrUq0N9IaweS
         4EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719767020; x=1720371820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5owlD5lltLvAbBD17/0DblPjtl+cJf7M5OuX1U77Xg=;
        b=vYAhRlmtnLT0hMUWo25eGncbLpTDEGktBnOI66aOs0PUvhhTju4b323iTsdaLvQDV0
         LKjKx/mx/2TjTwb4gbN+d2mBc/vMZAKD2lRTLXeJa+MGjt5vl8IuKIcdouYEw1eZgcQf
         1Q8kPqS6xedLNRFf0J51+P+sJ5ZCM6E6vhUA/rn/3/78ZohEZb3OMvNK1SwUQGHCcusD
         m63DojpezIw1NHaaiXg1tBQFVA+cnErqF2/T/JV1/x56zQIoMpMkt6McD/TFcScuCOGW
         wbINS5f6fSb9FHNNm04zcGf0IlYFlxj/XNWps/LNTWstwPuAUo+WZN0DJauM5dSIfB/l
         jSXg==
X-Forwarded-Encrypted: i=1; AJvYcCVztEjLRHTXNKINyxGas1gsMotTscjloIxmiwfcm1UvC0JOhFH9Yn2m+uS1ZYAUaFHoxR4n0o4r+WUSDPFQU1+cnAvB4fNnasr8cJUYt3cQKgL9RE5WVUkV5l0Zr8MMBosIstHl3w==
X-Gm-Message-State: AOJu0YzeOu0wCrolsGpUv8D6JKxkNkdFrP4iMsr9A03IxZ/MuA1RZXXV
	niaOh7FFP9MiZzUu67mqiOU8XcPgfrod/wzkkMVQhoptMK3NsAE1
X-Google-Smtp-Source: AGHT+IHYxsuWVeTEzWjVUqY7oP9c8XAbyyBTRknQeSpRCfFrevznM+SVVPU99dZ2H5Ae+KP5a75wMQ==
X-Received: by 2002:a05:6a20:4324:b0:1bd:23bd:4b9a with SMTP id adf61e73a8af0-1bef60f3bd8mr3111465637.9.1719767020235;
        Sun, 30 Jun 2024 10:03:40 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce17a77sm5078379a91.6.2024.06.30.10.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 10:03:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 30 Jun 2024 07:03:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Chen Ridong <chenridong@huawei.com>, cgroups@vger.kernel.org,
	Aditya Kali <adityakali@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Serge Hallyn <sergeh@kernel.org>, Waiman Long <longman@redhat.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4] cgroup/cpuset: Prevent UAF in proc_cpuset_show()
Message-ID: <ZoGP6uV2oD4AdYWP@slm.duckdns.org>
References: <20240628013604.573498-1-chenridong@huawei.com>
 <e5a78840-b623-485c-b467-828a5a0b7d37@web.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5a78840-b623-485c-b467-828a5a0b7d37@web.de>

Hello,

On Sun, Jun 30, 2024 at 11:20:58AM +0200, Markus Elfring wrote:
> Under which circumstances would you become interested to apply statements
> like the following?
> 
> * guard(rcu)();
>   https://elixir.bootlin.com/linux/v6.10-rc5/source/include/linux/rcupdate.h#L1093
> 
> * guard(spinlock_irq)(&css_set_lock);
>   https://elixir.bootlin.com/linux/v6.10-rc5/source/include/linux/spinlock.h#L567

I don't really care either way. Neither makes meaningful difference here.

Thanks.

-- 
tejun

