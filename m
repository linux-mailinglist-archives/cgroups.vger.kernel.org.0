Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC34186FDB
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2020 17:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbgCPQTK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Mar 2020 12:19:10 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43703 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731924AbgCPQTK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Mar 2020 12:19:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id l13so14660701qtv.10
        for <cgroups@vger.kernel.org>; Mon, 16 Mar 2020 09:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FGmHo0X0ug88xLxL5VEMvKfeQgO1Bzc/6oEObLpalt0=;
        b=SHgvwS9ZQXVqWJj5Zg/whvmP0uVvCvk7nB+wXhoy06AICUCarPw4d95BS7CJvG67UU
         NX8wP9DEQJ0mgCrwGOWKtNK59MMqvFI00+RHuh0T+yO1RTHxBEtxCbEK2FT8r+V2tB9h
         Mk1bzFa1SvwjUcS6Q7GSk61qqUhraymSLxN7La1EGmsw+Qxumbbns6Wb1kYMHPlLtkxe
         9JEk6yL6bHZszcytqNRZZSfQAp498YTvNeyQjFBVRM6Ckt1osk3zGZvEMoaGp9qkKZvP
         0ILeErzkPHYfFxCPj9zcFZL6pVv34cuxBMBtFOMl/RegHfvHd5bpoXm8eLeqMpNhP21R
         C0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FGmHo0X0ug88xLxL5VEMvKfeQgO1Bzc/6oEObLpalt0=;
        b=ay0GEcf+5i9VcFHu46gNetDWJB/J7kDGoh4p/INyZD+bIigbgVgv4eIIPzJxwfa7Lf
         el2M2TPt/B3DHdB+MY8O/1Z3iLZRKrgtOodPe4T18aqXQgNN85hHgeNQvVteZEt0ngRU
         K1sOmFRx2NNn+5Rmkbs/UwOiFy75VJChXdKDD3QgtDlbYljJ9qvoNuvPJyqyC5z7gHFc
         BwD+ggsATIwiBktIqAv99UeNX7zFfr1nRMOuZRjUnd7uiBWsFmeR8xHvVFabLItAqOMm
         e2W5A21SKPzEX3bZiJLVFGJxiPwPDk3n979CMGQ4pOzP3HyIXDmG6OE9oL7NHhQFZ9Cw
         vh0w==
X-Gm-Message-State: ANhLgQ31HWOYnKuFPeUGMCb2lAedBVdUAqJgEgDi+pdi2iBoUV4dYWIT
        rDXiEtaRTDXVqToUZPN7rC4jBQ==
X-Google-Smtp-Source: ADFU+vtx+zMj7eTBogu7AvmwKKGLCsGJnyGIB45kgyVWQ3gEMMOGIIAyfVwsIK6AVGNouJNqa0oo9g==
X-Received: by 2002:ac8:18f3:: with SMTP id o48mr897399qtk.368.1584375549434;
        Mon, 16 Mar 2020 09:19:09 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id y17sm108505qth.59.2020.03.16.09.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 09:19:08 -0700 (PDT)
Date:   Mon, 16 Mar 2020 12:19:07 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2] mm, memcg: Fix corruption on 64-bit divisor in
 memory.high throttling
Message-ID: <20200316161907.GE67986@cmpxchg.org>
References: <80780887060514967d414b3cd91f9a316a16ab98.1584036142.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80780887060514967d414b3cd91f9a316a16ab98.1584036142.git.chris@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 12, 2020 at 06:02:54PM +0000, Chris Down wrote:
> 0e4b01df8659 had a bunch of fixups to use the right division method.
> However, it seems that after all that it still wasn't right -- div_u64
> takes a 32-bit divisor.
> 
> The headroom is still large (2^32 pages), so on mundane systems you
> won't hit this, but this should definitely be fixed.
> 
> Fixes: 0e4b01df8659 ("mm, memcg: throttle allocators when failing reclaim over memory.high")
> Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@fb.com
> Cc: stable@vger.kernel.org # 5.4.x

div_u64 versus div64_u64 is really a handgrenade. We just fixed a
bunch of those in psi as well.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
