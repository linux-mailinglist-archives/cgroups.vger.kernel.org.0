Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE391B6A72
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2020 02:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgDXAqT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Apr 2020 20:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgDXAqT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Apr 2020 20:46:19 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926FAC09B042;
        Thu, 23 Apr 2020 17:46:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id hi11so3253506pjb.3;
        Thu, 23 Apr 2020 17:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tS4YR94ffeglZIc0ae9Egn1RyfphZpTWVsnteoZ0LM0=;
        b=JNykblARi0mDZ2qQGAafT9vjr7RYTEdye49idwBZWvbw63S4gUAY383YJ3i36TaQN3
         7GPxqLPQL4MgH2Iy1SgjYTAqnVojfdGr1oAXj/t8tm6XJmESgqS2p+jBk17ZAxIfXPAv
         QNtAt0fPaCFL9y8+4M6JMd9uDNA0PdZjiTmz16FtXfJr/M5/mZL76+11CaZ5ldaSYo33
         Yj3Y8OZdVmnoR2nOOTe+hM9TW1Z9V24kIcSXssRlFLXvZ7J4719aW8c4+r2xrtP2JuOV
         dOSc4OV8jOakzzXKq5M7Dpmlisf62SldrNpzAAYk//OrGQuPdsTe/q31tllBjaB3ejt2
         YAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tS4YR94ffeglZIc0ae9Egn1RyfphZpTWVsnteoZ0LM0=;
        b=Zd+nXA1fCOqCrSJIVrQ0+XYcNjPBWUTQChW4XzNXNLT0XdhEzZXzU8pzkxF634TGf9
         uN8EaVfCo1tgEsF9eyltos5a2Iwca84BKmy1tMAqV3Ciw6cAxuWwivlDxHkjORmGyUsh
         /BuIokiUhJRNj/fUJwkm7rdCdIn2FQH5CqYQxVes/wGQn41w0cpiLmer98jV9YGDtrQT
         DHiHZvGGOfn9ahBaLNEDcdpMchOPsr6yAcPQVXb3MD+gDhYJ5We8gu1IFQ0fX+JW2xOE
         LtPWBi6aUI/RXqGT7uv229KBV+9wqfJdmmE7BtjjphOjh6WwY6AP1KJ6j5293UtMeIo4
         7GZA==
X-Gm-Message-State: AGi0PuZRHTGD+KrsfPl7x3CpYau15Ug6MP7gzR3nkZjHsfRl1ns/CQYw
        kQgNykAHRTou+qfyStsWtDs=
X-Google-Smtp-Source: APiQypIf5EL7gbXv+LYJtnlaJpKanMqCYSIqoMtgaS2kytRzcq1J8MgoZ6DpUHRwMg8jejW5TUARkw==
X-Received: by 2002:a17:902:ac97:: with SMTP id h23mr6351821plr.89.1587689179156;
        Thu, 23 Apr 2020 17:46:19 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id w75sm3816369pfc.156.2020.04.23.17.46.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 17:46:18 -0700 (PDT)
Date:   Fri, 24 Apr 2020 09:46:13 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 17/18] mm: memcontrol: delete unused lrucare handling
Message-ID: <20200424004612.GG13929@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-18-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420221126.341272-18-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:25PM -0400, Johannes Weiner wrote:
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Code looks fine to me. With proper commit message,

Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Thanks.
