Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C796432313
	for <lists+cgroups@lfdr.de>; Mon, 18 Oct 2021 17:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhJRPkT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 11:40:19 -0400
Received: from sender4-op-o18.zoho.com ([136.143.188.18]:17899 "EHLO
        sender4-op-o18.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbhJRPkQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Oct 2021 11:40:16 -0400
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Oct 2021 11:40:16 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1634570567; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=SIztRUc9OQz6SZ051eIl/GUuuVi6UQupUR1dRGjXznCaZ8l9bplFLwtW353jA4hc6dDbxyVgm5eT69cjFKuu2IiHRBPqmSjoSdx7YCAusel16d+vq4MMzj8JE3mImBzkFyi5FqzBzixJ3qrG3Fh+OC0Ucnn3XyD7lFn4nbq9MKE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1634570567; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=kZhtruoVwNb47EYcsxuzHngcaBNhwqEKuTTcZhdi/HE=; 
        b=cYe4rVsidMUiSQijOj3zGKiTs6fGGlGD98uIHB8iQZ1AtnwyjIGUY7xovPVPvN6ebwWCdZpPtNa4NoGqNl/KoaIjHT5oFDWXgF6RzXEkIkxqhD0kf+o1INuZOC6UgKrV78+a2GOp+egHZOVWmQ3LCw5tlB6w2bFDU9F08x+W/z4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=librazy.org;
        spf=pass  smtp.mailfrom=im@librazy.org;
        dmarc=pass header.from=<im@librazy.org>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zoho; d=librazy.org; 
  h=message-id:date:mime-version:user-agent:from:subject:to:cc:references:in-reply-to:content-type; 
  b=TgijLkBzZ7Q/RMm2R9BF2LVqca7CTy+7KrSxYKdcFG+sSjpE5ei9w2qLu3ltiAVqRzUOoYskSVXR
    sJXnKMRgJRS0/EdWoc+RNVOksV7LizPRPMGhTDoebLKW/Rpse5NO2TirtU5MHMwMTYoNK1bkf1gv
    /CQRxyoT1OQyaxKOZRc=  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1634570567;
        s=mx; d=librazy.org; i=im@librazy.org;
        h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=kZhtruoVwNb47EYcsxuzHngcaBNhwqEKuTTcZhdi/HE=;
        b=e7gJw8grFe/k7pDLAMOlujFTGoN08nc2CVJ0B/nMAud9K5h962WRHocctzMz8bYP
        oTQsTq5HURE01HdTv9jGiA/yyr3VmDKTpa3cninBpo9msJugpIzgT6/XPkpz+jq0Uzr
        pDOV9nbkncx0MNUNPbKGdFrVnGkpzvamFM2Ma52s=
Received: from [192.168.8.8] (112.10.216.114 [112.10.216.114]) by mx.zohomail.com
        with SMTPS id 1634570563689491.1625136176144; Mon, 18 Oct 2021 08:22:43 -0700 (PDT)
Message-ID: <e726813b-4f6d-3a5d-6adb-8407a9b4c7f7@librazy.org>
Date:   Mon, 18 Oct 2021 23:22:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
From:   Liqueur Librazy <im@librazy.org>
Subject: Re: [BUG] blk-throttle panic on 32bit machine after startup
To:     zhangyoufu@gmail.com
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, tj@kernel.org
References: <CAEKhA2x1Qi3Ywaj9fzdsaChabqDSMe2m2441wReg_V=39_Cuhg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEKhA2x1Qi3Ywaj9fzdsaChabqDSMe2m2441wReg_V=39_Cuhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

Yet another colleague of the reporter here. I found that some 
precondition maybe not sound when tg->slice_end[rw] is initialized with 
0, which time_before(INITIAL_JIFFIES, 0) holds true in 32-bit Linux.

As in v5.15-rc6/block/blk-throttle.c

1. L833

	/* Determine if previously allocated or extended slice is complete or 
not */
	static bool throtl_slice_used(struct throtl_grp *tg, bool rw)
	{
		if (time_in_range(jiffies, tg->slice_start[rw], tg->slice_end[rw]))
			return false;

		return true;
	}

throtl_slice_used will always return true for a newly initialized slice.
This may be intentional behavior but not mentioned in comment.
(except when jiffies == 0, which is another topic: will 
time_in_range_open do better here?)

2. L791, in throtl_start_new_slice_with_credit

	/*
	 * Previous slice has expired. We must have trimmed it after last
	 * bio dispatch. That means since start of last slice, we never used
	 * that bandwidth. Do try to make use of that bandwidth while giving
	 * credit.
	 */
	if (time_after_eq(start, tg->slice_start[rw]))
		tg->slice_start[rw] = start;

As mentioned in my colleague Haoran Luo's reply, time_after_eq(start, 
tg->slice_start[rw]) is falsy when the jiffies had not wrapped around.
A easy solution is to add a check for tg->slice_start[rw] == 0, or we 
should initialize tg->slice_start[rw] and tg->slice_end[rw] with 
INITIAL_JIFFIES.
