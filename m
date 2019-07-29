Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB95D78FD4
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2019 17:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbfG2Ptz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jul 2019 11:49:55 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43334 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387663AbfG2Pty (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jul 2019 11:49:54 -0400
Received: by mail-vs1-f65.google.com with SMTP id j26so41113159vsn.10
        for <cgroups@vger.kernel.org>; Mon, 29 Jul 2019 08:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uUW0YKHPLieEQydyNjaqE+DPJSP/Cf4fqcZtPwBzjUQ=;
        b=Cc+rnM3wvWjLyuINuMWXDGs5fxT5e9t10JNduKKSfTicMo308IATLLWRf1HbfpWVFJ
         b9HvoMhkEEadSy05edUEx8sn1mVyofmiYp6O2xYQvx9A1WtU4SuHaPssop3lf5ncDbCt
         yG5gMY4JLtex+4bR+Q44glXssu1lBsGRrlcGVKY1Zanm/FcxXPu9Lpcm8BrKG2Kqswp+
         rb3AJRXbn4R0hDAXhtZXs3XIx2+JoGwvRFnm4k9C4FTS9vMmF8Ya9luCi/wweOUwz+Vp
         ouAIcGKMhFgKox4L1g3oYilw3A/fOpStl9pHs6Z5h8qQlenPlAGWPeZVHxefOnX7b/y2
         zufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uUW0YKHPLieEQydyNjaqE+DPJSP/Cf4fqcZtPwBzjUQ=;
        b=OKAeIxBmbxM2X9OXI79+Ixi2loIJhBuKNlqs6Xo5P7EDfMLiclju1VYVaRJw98paOU
         7mn5Pxs2TZwZm9bF7sHnvqbXl+WpYr+IG6XqQRM2ajRKXdhZ2gAS1YlwMin1Ty4RE6QN
         Fvv5lWuKWiHTImamqhOC2Rp3km3ebBnelUMUdN8DQIw0EsZAeaq8dP5JtA7ocn0V8/wj
         HapeSioieiTKLw4DcD8IWQLhYF5Dt3IZCqEN8YUvRmFS3Z/cG5A63eBXdZdeUdKfivrP
         Gnzh5IjylVHuAZDKWbtfaIOif+medeSu07mHQ9tfoeE5X3/ABk8TQM4UaIln6ScOx7vc
         Tzzw==
X-Gm-Message-State: APjAAAVwb3heo4NLG7nh7xncE1n9a7n00JBFeO02toQtapIs8ebLK/yj
        oTGUwA5h1SgJonNk8dNZM9k=
X-Google-Smtp-Source: APXvYqzvvmRlC370jmHcQF5fxfCKQPBjEkd1dfVOREKA/n9iD4FSeCbNS9niC5SCPNU2sBDZeyzhIA==
X-Received: by 2002:a67:7087:: with SMTP id l129mr68222271vsc.206.1564415393680;
        Mon, 29 Jul 2019 08:49:53 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id q15sm25893828vka.44.2019.07.29.08.49.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:49:53 -0700 (PDT)
Date:   Mon, 29 Jul 2019 11:49:52 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit
 in get_user_pages loop
Message-ID: <20190729154952.GC21958@cmpxchg.org>
References: <156431697805.3170.6377599347542228221.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156431697805.3170.6377599347542228221.stgit@buzz>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Jul 28, 2019 at 03:29:38PM +0300, Konstantin Khlebnikov wrote:
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -847,8 +847,11 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>  			ret = -ERESTARTSYS;
>  			goto out;
>  		}
> -		cond_resched();
>  
> +		/* Reclaim memory over high limit before stocking too much */
> +		mem_cgroup_handle_over_high(true);

I'd rather this remained part of the try_charge() call. The code
comment in try_charge says this:

	 * We can perform reclaim here if __GFP_RECLAIM but let's
	 * always punt for simplicity and so that GFP_KERNEL can
	 * consistently be used during reclaim.

The simplicity argument doesn't hold true anymore once we have to add
manual calls into allocation sites. We should instead fix try_charge()
to do synchronous reclaim for __GFP_RECLAIM and only punt to userspace
return when actually needed.
