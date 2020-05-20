Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F2A1DC335
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 01:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgETXuA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 May 2020 19:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgETXuA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 May 2020 19:50:00 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBC3C061A0F
        for <cgroups@vger.kernel.org>; Wed, 20 May 2020 16:49:58 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id s19so5163749edt.12
        for <cgroups@vger.kernel.org>; Wed, 20 May 2020 16:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RUfnz+3+Nkh58pbHAS8sjZcUPVeApODwUMmXr4NI2ZY=;
        b=cVDVhHg2q1D6nCUuevO4L9GrF42LCXBhesqGp2oqY+Szm4s6/HGyDkVnnMedHOHVZK
         LykgwAJlryPBcvuXF2ra2GGQUtGGoixKRuBRkoY1hdDKfDap9f7d9cIDRAT5LFl2IHF2
         KeOEFtHXVSe0jQ+iHUDUT/yqM7+JGeJa+akrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RUfnz+3+Nkh58pbHAS8sjZcUPVeApODwUMmXr4NI2ZY=;
        b=jfOJZe8gqVU8kUpnr+kEY63Ep27i6yxrfDFkFemNbc6LbxMQ+F/rXb5wUm8fxJeB8Z
         dFLqZUCU63Xw1wvc6/OWtYPe7kNtuGbwzYc0SKUB0u2yz8aNdQ1aIXA1f3F+LC3pSHvt
         BRgqHqhG2nLXJx+1sOqV0Mui4pNw1fuN1kL+RHMr+XLDXTqPpe/DauMJhF0p/Odsn+IJ
         mk572PUsWMZ4/jFr+YbDlWt6bDzJ/1K2Mvq5VIf8iVmHgper7f8cB1iz049hRKU/bc2W
         G7+4zgnWLBs4XzO97nvuxTxWAelOf5fRPUK3QpP5O6Itr2v8ZxYS7hisLxzIWA5vtyKN
         oWJQ==
X-Gm-Message-State: AOAM531aK+QPl4IYbQ+met4ZhUH3tY5BCIg4p97WoqG4dsykw0D7/5zM
        9tTfZhqbsb0pDQ0PcD/O/Gzm1w==
X-Google-Smtp-Source: ABdhPJznwU1I3lqQRpLIzH8obpgeUm97jbOZSvYmp+dcp94Vi9i1I3/6JvVjoaU3Frm22nn60f3clw==
X-Received: by 2002:a50:b586:: with SMTP id a6mr5514320ede.292.1590018597141;
        Wed, 20 May 2020 16:49:57 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:4262])
        by smtp.gmail.com with ESMTPSA id x8sm3268142edj.53.2020.05.20.16.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:49:56 -0700 (PDT)
Date:   Thu, 21 May 2020 00:49:56 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: unify reclaim retry limits with page allocator
Message-ID: <20200520234956.GA892595@chrisdown.name>
References: <20200520163142.GA808793@chrisdown.name>
 <20200520164037.e3598bc902e39415f4c263e7@linux-foundation.org>
 <20200520164243.56133fa135f65cc708e70ec0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200520164243.56133fa135f65cc708e70ec0@linux-foundation.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hey Andrew,

Andrew Morton writes:
>Ah, my habit of working in reverse time order sometimes does this ;)
>
>I suggest that "mm, memcg: reclaim more aggressively before high
>allocator throttling" and this patch become a two-patch series?

Sure, they can do (sorry, I meant to add a comment mentioning the dependency, 
but forgot). I just didn't want to conflate discussion for both of them, since 
they are separate in nature :-)

I'll hold off on sending v2 until the discussion with Michal is finished.
