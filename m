Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6913A3B84ED
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 16:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhF3OUH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 10:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhF3OUH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 10:20:07 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F90EC061756
        for <cgroups@vger.kernel.org>; Wed, 30 Jun 2021 07:17:38 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id u14so2382657pga.11
        for <cgroups@vger.kernel.org>; Wed, 30 Jun 2021 07:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5fNIFXYQI7TvZny7BzFwsgeK80xRoPJ6rxa13naW5Mw=;
        b=teRsrW5ftbOQTTpZQ41lXoQW13k4U4jqQtusMwiMeetCR789nTMf35ZMVYuJ9tM3Y8
         N56uC5ewiwmRYwx+5eL+p9qBD+COF/anx6cWOGGXH3c9nrX0mzSVaYqNSXq+MtFXBZX7
         Z976/QYHRm0yqG7OBoqy3GA/HlQTwBSl8OBP0Xwdaph3qaRkFNKnspVn2x2R0LAgpu1F
         NXZ+HZ5bHUHdC8JbIawg0O8PHZq2AgDmTbnkP9E60CAqfncly+gxWmRiUpzWMOnNny9+
         Qe99mN+f99wA9XkJv6R6jqXLU+64iSnRjyROE7EQABE2ql6yB9w1KNJMvkE4KWtbB/zP
         pbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5fNIFXYQI7TvZny7BzFwsgeK80xRoPJ6rxa13naW5Mw=;
        b=lE4lZJ2sCxuQyvJeiNEKkjya1rsKXa8nedPeezrjKZO7gjTkm6YEwJTUnAwXbusylw
         ix+RyzgGB+THxdUueqmdW5rupAMgOxe9LAKMSwX6XPTkQbgJw/flfPyaermoHrlWfiSD
         5Mu1GMYslNEOVbpFcrc6kdJJ40pijHFpdc4yN4XEpt9CMG2E6tDhzglHP2DC7sfZ2Lz/
         nj8T8VR9Rp2UnHWTVa6voCwsXnamuWf+FflAwKjayxUl9TaLuNqmWEKOmT6uzP8zdBD3
         EfAd/6iIzzhWOvLAMT9OndRiDPnqKukcyK9QzpP0CZUmgCQ3LsGsxDWul1CglsjYI6ls
         q1hA==
X-Gm-Message-State: AOAM5316JebbJ76El8E5GyD4wH2BCIHT0nt7/5hsZjPiv39xBRKWfct/
        GOt6OxLtC2VAcQM/Rq7eTyS4bQ==
X-Google-Smtp-Source: ABdhPJyn8XeXTZrY/DcyDSy3p4CP6mkFu5UVfXv0eFaDExJFSXtVwosgbiM/4FGppcnx8fRZ5PF0Ug==
X-Received: by 2002:aa7:8154:0:b029:310:70d:a516 with SMTP id d20-20020aa781540000b0290310070da516mr3267536pfn.63.1625062658223;
        Wed, 30 Jun 2021 07:17:38 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:14ba])
        by smtp.gmail.com with ESMTPSA id e13sm21224345pfd.8.2021.06.30.07.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 07:17:37 -0700 (PDT)
Date:   Wed, 30 Jun 2021 10:17:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 02/18] mm/memcg: Remove 'page' parameter to
 mem_cgroup_charge_statistics()
Message-ID: <YNx8/3FmctUIMR5x@cmpxchg.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-3-willy@infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 30, 2021 at 05:00:18AM +0100, Matthew Wilcox (Oracle) wrote:
> The last use of 'page' was removed by commit 468c398233da ("mm:
> memcontrol: switch to native NR_ANON_THPS counter"), so we can now remove
> the parameter from the function.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
