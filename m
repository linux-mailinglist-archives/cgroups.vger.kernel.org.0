Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4499F4713A
	for <lists+cgroups@lfdr.de>; Sat, 15 Jun 2019 18:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfFOQUJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 15 Jun 2019 12:20:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41553 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfFOQUJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 15 Jun 2019 12:20:09 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so1168881qtj.8;
        Sat, 15 Jun 2019 09:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eX2SsF5NLCHpL5vWayCPj5W8iQ02n38k3DDKs0RQPsc=;
        b=r+pPrVqAooiurT+r/1q1YOmCwatUD8JpCV7NTTno22ito/5zCfh0NLhl4iMS76Apur
         od3597crTGgH49Iea/iv0Hn+0dlF/nDVBakGN4yUlzBbBCV7oNn3R/Bmj4uooW+AvzSq
         CoDrMHiPzNMxHFiIA2AVcMJEvoDu3Sre8J0jWQfHXmstDyO/JzqBUfsw3itDzLJSBcrs
         ygygJfj+TtVYs+wlFzjkcpQDIS/nIKFEb6axYc6x/QK0djwkF2fCJNAc/y61BV3vka5B
         8mAN5LXYOY+ViRwZe6TnrbIBxANgmaxXVVIjq7dZoY1LghPPCg6/kI93rpDyZAqEeGiF
         eErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eX2SsF5NLCHpL5vWayCPj5W8iQ02n38k3DDKs0RQPsc=;
        b=bHLE+hhJeQZtg7O3aDuwX5PK63mfytxyqOB+l/udIFIr4IuRJnRPOey6wbShHUcIrg
         g/d88WXsLclyvTXHIP6HHfZUr6j9DmqXfYJlMZ+/ocBUXZDt8PMMY1AY602LXWDJVMKY
         U1ZuJuwiOY7JCGa1VOAM+xCTDnmvPT6HAAXSJz3qfDyy+2JgN976+UEhNYNmo2kmvV4g
         ndl5u31mz7IK+FyGx+Jp7eo//3vklXMnVpq4H+zwxKF/Xa58hUKeu8CarOtQoeJnt4zo
         GaKzG6ByCjgk9OZt4btGgZUrabXY5MqNjw2Ms5Ketxho+YxEuhdtykUq7CZdr9lQJo6u
         PKGQ==
X-Gm-Message-State: APjAAAWjK6OsiaC5hOVb2LtUW12CfbrkdnjvvSF22n6q1O6FIYw5PsYk
        JJv33sxZTdjeypslCGOIYWM=
X-Google-Smtp-Source: APXvYqzYKArsrn7PLBHxWCNzaRPRtCR+Ia5hnnBaEJfJot7DPD4U31BQXQuIuLwjHEBGGLC6yj+Wdw==
X-Received: by 2002:ac8:1e15:: with SMTP id n21mr59570805qtl.20.1560615607770;
        Sat, 15 Jun 2019 09:20:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::673a])
        by smtp.gmail.com with ESMTPSA id 5sm3807720qkr.68.2019.06.15.09.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 09:20:06 -0700 (PDT)
Date:   Sat, 15 Jun 2019 09:20:04 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Xi Ruoyao <xry111@mengyan1223.wang>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dschatzberg@fb.com
Subject: Re: [PATCH RFC] mm: memcontrol: add cgroup v2 interface to read
 memory watermark
Message-ID: <20190615162004.GG657710@devbig004.ftw2.facebook.com>
References: <0f1be041f8de95603753ffe989bd25069efa13bb.camel@mengyan1223.wang>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f1be041f8de95603753ffe989bd25069efa13bb.camel@mengyan1223.wang>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jun 15, 2019 at 04:20:04PM +0800, Xi Ruoyao wrote:
> Introduce a control file memory.watermark showing the watermark
> consumption of the cgroup and its descendants, in bytes.
> 
> Signed-off-by: Xi Ruoyao <xry111@mengyan1223.wang>

Memory usage w/o pressure metric isn't all that useful and reporting
just the historical maximum of memory.current can be outright
misleading.  The use case of determining maximum amount of required
memory is legit but it needs to maintain sustained positive pressure
while taking measurements.  There are efforts on this front, so let's
not merge this one for now.

Nacked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
