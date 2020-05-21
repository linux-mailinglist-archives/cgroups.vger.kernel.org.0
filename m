Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82E01DCCD1
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 14:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgEUM2U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 08:28:20 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36959 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgEUM2U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 08:28:20 -0400
Received: by mail-ej1-f68.google.com with SMTP id l21so8590212eji.4;
        Thu, 21 May 2020 05:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x7HgeO9Wvnx9mP+TZwfptn5IG/xaG2iUlETmitshdYQ=;
        b=CEK+ADVXgsZ8GHDyLPsaLpQc7/aP7phv/xjNyywIBaBmlEFu9wt0UZ+90wkWbVL/oG
         WLPCf8fHKoOT0wXRxfjjmtFAzBOD5vekDL8woP8GVgdMo1l7qvCwewH6Ri0sIsBY7PbS
         DLVhvNkmv38y0iA7A+BjR+ul9tFLWInGliA3+ZevT7kY3oXH6wgYw14KK2kH9JXEIfER
         45Xfi72Jc//7ZMmcTsZYoiWSwuzg9S5fUJwqp01tX42blf7Np1nsBCQIQS4FvSoWcdx8
         tUJkIkj6Mrcyl8KAa3YjQTbpv4/7ruvfgU+feRIBUrYs1YuI1MA0SdvJrFxe/iyIPow0
         cNXQ==
X-Gm-Message-State: AOAM5329mB2j2k7xIMVx9JEugKWQ7nv+fXsAMcdQ4O0gq7iio4pjmDQV
        mdHYDbGHtV4J1AUuuyUqn8U=
X-Google-Smtp-Source: ABdhPJwU1TxI7Iw7jPzJ9tumWfRUHFAImd6A3+apajoIYs4m83HPBzUZydLFJUQoC7dh0hPotkQ/eA==
X-Received: by 2002:a17:906:1c94:: with SMTP id g20mr3176649ejh.319.1590064098014;
        Thu, 21 May 2020 05:28:18 -0700 (PDT)
Received: from localhost (ip-37-188-180-112.eurotel.cz. [37.188.180.112])
        by smtp.gmail.com with ESMTPSA id bz8sm4610805ejc.94.2020.05.21.05.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 05:28:16 -0700 (PDT)
Date:   Thu, 21 May 2020 14:28:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521122814.GN6462@dhcp22.suse.cz>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520202650.GB558281@chrisdown.name>
 <20200521071929.GH6462@dhcp22.suse.cz>
 <20200521112711.GA990580@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521112711.GA990580@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 21-05-20 12:27:11, Chris Down wrote:
[...]
> Regardless, you're pushing for different reclaim semantics for memory.high
> than memory.max here, which requires evidence that the current approach
> taken for memory.max is wrong or causing issues.

Sorry, I have skipped over this part. Memory high limit reclaim has
historically acted as a best effort action to throttle the
allocation/charge pace. This would work both if the implementation
simply tried to reclaim down to the high limit or if the reclaim is
proportional to the memory consumption by a specific consumer. We do the
later because it is much easier to establish fairness for. If you want
to change that you somehow have to deal with the fairness problem.

And yes, we do not guarantee any fairness for the hard limit or direct
reclaim in general but that behavior is generally problematic and there
should be really strong arguments to move high limit reclaim that
direction IMHO.

-- 
Michal Hocko
SUSE Labs
