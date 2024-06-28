Return-Path: <cgroups+bounces-3441-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0658391B7D0
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 09:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36175B21AE3
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 07:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D86125AC;
	Fri, 28 Jun 2024 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gqWRMLf/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A401E13DDC9
	for <cgroups@vger.kernel.org>; Fri, 28 Jun 2024 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719558561; cv=none; b=gU/Xs24e9x3BRbucfhCCUb2Ty6za7AgwOaCQrrd5kk4J39+G6eOyV40ixL+T2Y6pi34lwHhUhN/30HNipE+G4GHAFH9SrxEhYBNym+OFlgfCbu03eMAF7n5tGZCyvXTRLwT8gOAdWbTGRXQVo/Lw+EE25sbwBZOxf+zPugEkKOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719558561; c=relaxed/simple;
	bh=jmkqfXaHVKyVHT3TgRBCSqe08GGcFE1IfnnRPRkO9G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzqhr8oVHbbQTR35p99y0rbw4Y6HuXCQ9SRW9SrZsq2ahIwQFTGqj7fQujhFgW3x/m/Cm11RrwUY406uTSzSpjHQlMY16CTNxUriug/QYlNkQ7yUODKH2Z+aA+RIrRdBluQ7YvHqdpgCylu+K5N337NPNP4YgPudA7IOxhPFIBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gqWRMLf/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a72af03ebdfso30093266b.3
        for <cgroups@vger.kernel.org>; Fri, 28 Jun 2024 00:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719558557; x=1720163357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=If0iq5oLy+eiIvzlGQNRLUuZgZ1JLzU6wSKruP4/9Eg=;
        b=gqWRMLf/NX3cGZidAZx8SJUoLNhx0y0kBDeWvBt8VDQAW1FpnA2O0I7Tswihyg8EkP
         ZiEXF++PZFofLLSDMeLl/NpN7NIIOTnGziD6PrMP3RqPOlYx0yPF/OwY0RZB+0uxvyZZ
         mRGZEwOJzugdOX2fLHxmSJ35yxEGrys7SPJce7JmTJhiHlSd9C7KAiafc6zfRHaMAbaC
         Ki84cIOPjiO89LrNy2y9DT1ap+SDI7m47FOsNyQ+OMw9fCot9EI7tbWQDQLuBkTTxdTG
         yFWB8emT3atrbrVtWBMaWRR9Mx4KnmM6eR6psvCJdgaSLV9rtUjitSOhfvAn+Ch54GZT
         W8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719558557; x=1720163357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=If0iq5oLy+eiIvzlGQNRLUuZgZ1JLzU6wSKruP4/9Eg=;
        b=vR6U/Qalr2zhAS0Ve5tnIJTbtWCUnd/URdvM+j0YYHKc1R38EWVrTc930ZPtCyI2v5
         m/AlbJ8hhTHkXBkvVKx1pbmG/njFSyfaAUsDtcfN9ECSaU1LbwlfPK7H5ISMSKpA8SSk
         MnqDOK2kBvsBUE3nZ9EtGMh0S70Uan8sfJcFDwSVwNNpIhmetvnQkGBgv/0BWLunrusY
         FttUdtiBeUHA9RQhfJm4cIDXILRW1Yg8mU3mwOsNyQOU6dghJ4Bi25eu7A+/L3X+5Vk+
         AsXKVr0FggROkl3LHbvXZV4H0hC5ZoJwR9bGon0wffv+/PmPjS55dP+Zk8a5d8Lk/vzh
         S2eA==
X-Forwarded-Encrypted: i=1; AJvYcCWlSCG9hbb6g+K98Z5yZN7nIyl3NaT4YgaAeMnczvnV8MPn6PR+Krjm1K2Rx5AgfOOMSFWCIsXsxLbUuCT+6Orut6Ci/tu6Gw==
X-Gm-Message-State: AOJu0YzUywMVb4STmmgCdNAqOtGjAzcNBnLK9wAv/hJqDaiTAaFUphzi
	bDSdL2ctG49dnjFZvX17pad8xTGJNubboW8rPQJZRAtT9Xa/uBs5eJf7HyRTtrI6sNGSgFXjxFc
	c
X-Google-Smtp-Source: AGHT+IHI8uJ1o7wEPXjrRlqBMAxE/hZW7hfP6KthuUiDb9dgFhsbRFiAQwu4+lO0LtbeeWla+b5xVw==
X-Received: by 2002:a17:906:3383:b0:a72:438b:2dfe with SMTP id a640c23a62f3a-a7245cf26e7mr845900966b.40.1719558556886;
        Fri, 28 Jun 2024 00:09:16 -0700 (PDT)
Received: from localhost (109-81-86-16.rct.o2.cz. [109.81.86.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab0651dfsm47940966b.142.2024.06.28.00.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 00:09:16 -0700 (PDT)
Date: Fri, 28 Jun 2024 09:09:15 +0200
From: Michal Hocko <mhocko@suse.com>
To: xiujianfeng <xiujianfeng@huawei.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: memcg: remove redundant
 seq_buf_has_overflowed()
Message-ID: <Zn5hm4HHYIUVZ3O3@tiehlicka>
References: <20240626094232.2432891-1-xiujianfeng@huawei.com>
 <Zn0RGTZxrEUnI1KZ@tiehlicka>
 <a351c609-4968-398a-9316-2ad19d934e9c@huawei.com>
 <Zn1LFyO_cww9W758@tiehlicka>
 <10b948cd-5fbf-78e7-c3e8-6867661fa50b@huawei.com>
 <Zn1S70yo4VQ24UNT@tiehlicka>
 <ad7cfc60-d6d5-ca16-c93a-d200febccc9b@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad7cfc60-d6d5-ca16-c93a-d200febccc9b@huawei.com>

On Fri 28-06-24 10:20:23, xiujianfeng wrote:
> 
> 
> On 2024/6/27 19:54, Michal Hocko wrote:
> > On Thu 27-06-24 19:43:06, xiujianfeng wrote:
> >>
> >>
> >> On 2024/6/27 19:20, Michal Hocko wrote:
> >>> On Thu 27-06-24 16:33:00, xiujianfeng wrote:
> >>>>
> >>>>
> >>>> On 2024/6/27 15:13, Michal Hocko wrote:
> >>>>> On Wed 26-06-24 09:42:32, Xiu Jianfeng wrote:
> >>>>>> Both the end of memory_stat_format() and memcg_stat_format() will call
> >>>>>> WARN_ON_ONCE(seq_buf_has_overflowed()). However, memory_stat_format()
> >>>>>> is the only caller of memcg_stat_format(), when memcg is on the default
> >>>>>> hierarchy, seq_buf_has_overflowed() will be executed twice, so remove
> >>>>>> the reduntant one.
> >>>>>
> >>>>> Shouldn't we rather remove both? Are they giving us anything useful
> >>>>> actually? Would a simpl pr_warn be sufficient? Afterall all we care
> >>>>> about is to learn that we need to grow the buffer size because our stats
> >>>>> do not fit anymore. It is not really important whether that is an OOM or
> >>>>> cgroupfs interface path.
> >>>>
> >>>> I did a test, when I removed both of them and added a lot of prints in
> >>>> memcg_stat_format() to make the seq_buf overflow, and then cat
> >>>> memory.stat in user mode, no OOM occurred, and there were no warning
> >>>> logs in the kernel.
> >>>
> >>> The default buffer size is PAGE_SIZE.
> >>
> >> Hi Michal,
> >>
> >> I'm sorry, I didn't understand what you meant by this sentence. What I
> >> mean is that we can't remove both, otherwise, neither the kernel nor
> >> user space would be aware of a buffer overflow. From my test, there was
> >> no OOM or other exceptions when the overflow occurred; it just resulted
> >> in the displayed information being truncated. Therefore, we need to keep
> >> one.
> > 
> > I've had this in mind
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 71fe2a95b8bd..3e17b9c3a27a 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1845,9 +1845,6 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
> >  			       vm_event_name(memcg_vm_event_stat[i]),
> >  			       memcg_events(memcg, memcg_vm_event_stat[i]));
> >  	}
> > -
> > -	/* The above should easily fit into one page */
> > -	WARN_ON_ONCE(seq_buf_has_overflowed(s));
> >  }
> >  
> >  static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
> > @@ -1858,7 +1855,8 @@ static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
> >  		memcg_stat_format(memcg, s);
> >  	else
> >  		memcg1_stat_format(memcg, s);
> > -	WARN_ON_ONCE(seq_buf_has_overflowed(s));
> > +	if (seq_buf_has_overflowed(s))
> > +		pr_warn("%s: Stat buffer insufficient please report\n", __FUNCTION__);
> 
> I found that after the change, the effect is as follows:
> 
> # dmesg
> [   51.028327] memory_stat_format: Stat buffer insufficient please report
> 
> with no keywords such as "Failed", "Warning" to draw attention to this
> printout. Should we change it to the following?
> 
> if (seq_buf_has_overflowed(s))
>       pr_warn("%s: Warning, Stat buffer overflow, please report\n",
> __FUNCTION__);

LGTM.
-- 
Michal Hocko
SUSE Labs

