Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C1E230C06
	for <lists+cgroups@lfdr.de>; Tue, 28 Jul 2020 16:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgG1OHP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jul 2020 10:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730324AbgG1OHN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jul 2020 10:07:13 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8867DC0619D2
        for <cgroups@vger.kernel.org>; Tue, 28 Jul 2020 07:07:13 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d6so6949249ejr.5
        for <cgroups@vger.kernel.org>; Tue, 28 Jul 2020 07:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QDO5xtNZ22C72a1tBmEqwRX/00TFY7M8B1T43bXeDoo=;
        b=SLaBgESU+1xIJqSNqhieu03SNXKyKL+9MH8hgBEP20Gv4XC0tv7Aigf51SuYFDsJ0+
         09GIRi4cOnfUbvnWrtl2Bj6Hz1USuSfKPbNvwk6y0GavN4M4MAnesqzHkieumXy0qARA
         QDirQJmvwSNdLa088Smv1pEnZ7tVhoCsP9bwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QDO5xtNZ22C72a1tBmEqwRX/00TFY7M8B1T43bXeDoo=;
        b=U3vlUAwmmJMWk/9P4P/jceicKtlkf1ryAKSl4UE5g4xaU0aAjoGogMi2LZSW7O4jKH
         AedIV2YXijFIo5+evC5cEw0bhaN98rFCVkF0jcuohetaxG+ltcZtd9hb3CTBi30RXUkm
         pa46QvEXP6UNm3EciYBGbvSbmd39fAet0Zg0qJgrcjDnO/aIHD/PM+xUv7VQBj10YYMZ
         5wAfMmnO04J+qTEYRLJurkE36q3Qhf6li99kyxf53aMBjdrrtuP/ooVGVmJzINqf0Y17
         7vX97zDmj3oyCgwnzmBqBc575x8Xsy7Ns0z6WxBAZuzbK8LSEU19vBJI4Fv8wc4vU6vw
         EUNA==
X-Gm-Message-State: AOAM530RUbw2Ks9sorf57ODdVGmzOfsMzN6zDadi9jWi1rT0DVSag27W
        njHwItgOw8QTBRKxuPz/WSxurA==
X-Google-Smtp-Source: ABdhPJxZ3wtzuEqLcFixIKCJsMltmAzdJGoi38PMs9K9jHC/4Hd5c2yQLO2nF6gN4LZSUmJ0jmor/w==
X-Received: by 2002:a17:906:854d:: with SMTP id h13mr13570039ejy.446.1595945231802;
        Tue, 28 Jul 2020 07:07:11 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:f8d8])
        by smtp.gmail.com with ESMTPSA id p21sm6722487eds.11.2020.07.28.07.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 07:07:11 -0700 (PDT)
Date:   Tue, 28 Jul 2020 15:07:11 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: restore proper dirty throttling when
 memory.high changes
Message-ID: <20200728140711.GA196042@chrisdown.name>
References: <20200728135210.379885-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200728135210.379885-1-hannes@cmpxchg.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Johannes Weiner writes:
>Commit 8c8c383c04f6 ("mm: memcontrol: try harder to set a new
>memory.high") inadvertently removed a callback to recalculate the
>writeback cache size in light of a newly configured memory.high limit.
>
>Without letting the writeback cache know about a potentially heavily
>reduced limit, it may permit too many dirty pages, which can cause
>unnecessary reclaim latencies or even avoidable OOM situations.
>
>This was spotted while reading the code, it hasn't knowingly caused
>any problems in practice so far.
>
>Fixes: 8c8c383c04f6 ("mm: memcontrol: try harder to set a new memory.high")
>Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Chris Down <chris@chrisdown.name>
