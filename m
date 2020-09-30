Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6337127F0B9
	for <lists+cgroups@lfdr.de>; Wed, 30 Sep 2020 19:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbgI3Rtz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Sep 2020 13:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgI3Rtz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Sep 2020 13:49:55 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24523C061755
        for <cgroups@vger.kernel.org>; Wed, 30 Sep 2020 10:49:55 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id v123so2297661qkd.9
        for <cgroups@vger.kernel.org>; Wed, 30 Sep 2020 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vyr+bGNQ+ADwyxSKdcsVjSMXuNPRYBC2cBmRunOjdbs=;
        b=dnsurlXcEPeVFg0ocM0daUICy4W99fJqZzyAjbhM4+EC7IJsPDhfZo/+7MbO6qdKHk
         TaRoaPtLNOWRr/HDuktJDe7ldBOJk8BCSuHDsU4ggHkKu8aj7KKJvYU2q9fHICAItYh7
         4zEN8xGnWOeSAbHWWNW2OpJ/B4ZsDT/RV73sZNfW8IUwm8bpac4W6+gEOilF025egx76
         XbWleLvZ23pPyJaBoGv3pASIiz6fu5+XxxCZ2WJpbkvw5ZqpVs3iBrw16BOW8rO8PM5g
         ctbBu3DLCBnBkihzduZNHpSVZ/y6STrzqVIxKy2RtLoJUe+WoxqOjiuRbIRKt9BGLrBU
         OPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vyr+bGNQ+ADwyxSKdcsVjSMXuNPRYBC2cBmRunOjdbs=;
        b=iQ7ZvD668AfboYirzKSszeGqEd5Ui15NmRw59A+OuwC1KljjaFnHmOUArLNL7c1FUK
         hj7lwfGRaLbzmkaoppwBOhD2XJ/mDKZW0QB3SH4Fg9Mcbm/RcIbM6v1ndKfsbWI9KEOf
         POzM1Q7f6Q67CMLJLj03dPppc9TmpNh6BUOewqB/LwQsyoFqXyMuHRAI03CE9dBjgWFd
         bSgwXM/Jiz/9fGGT7fFp9tmpKOOu6pepRXMKP16oDJXO5Wx4pOpQ2cZBBQIQAHi6dTVl
         AyWxYPX5Wi8w5+U7c7rZl5KGlkdRDwq4DzKqs5uHsoMpFRvl6VE2321vdJ4wVAfqvrG+
         k3eg==
X-Gm-Message-State: AOAM531vsF8Ss/LnxSaZnHDAekPrOxTTe36g2cs3Yg7f3ZszoM9ESjPy
        vwsvw4L8h1VqOkGeGwApW5A=
X-Google-Smtp-Source: ABdhPJyJNmOd/SRaIY6ruoCf7EnouXDmcILujK64P3L9H+iC7gG8XxqdJUKq86gZUxpy/Cck9SIAnw==
X-Received: by 2002:a37:a6c3:: with SMTP id p186mr3762611qke.237.1601488194251;
        Wed, 30 Sep 2020 10:49:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e9fa])
        by smtp.gmail.com with ESMTPSA id v90sm3223983qtd.66.2020.09.30.10.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 10:49:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Sep 2020 13:49:52 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Jouni Roivas <jouni.roivas@tuxera.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup: Zero sized write should be no-op
Message-ID: <20200930174952.GG4441@mtj.duckdns.org>
References: <20200928131013.3816044-1-jouni.roivas@tuxera.com>
 <20200930160357.GA25838@blackbody.suse.cz>
 <20200930160619.GE4441@mtj.duckdns.org>
 <20200930163435.GB304403@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930163435.GB304403@tuxera.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Sep 30, 2020 at 07:34:35PM +0300, Jouni Roivas wrote:
> > So, I'm not necessarily against the change, mostly in the spirit of "why
> > not?".
> 
> There's actual user space application failing because of this. Of course
> can to fix the app, but think it's better to fix kernel as well. At
> least prevents possible similar failures in future.

Just for the record, none of these pseudo interface files are expected to
behave like real files. The supported usage pattern is - open, read with
sufficentily large buffer till EOF and then close, or open, write the
content in one go and close. There are some exceptions and we add
convenience features when the cost is low enough but beyond the core usage
pattern the boundary between what's supported and not is pretty mushy.

Thanks.

-- 
tejun
