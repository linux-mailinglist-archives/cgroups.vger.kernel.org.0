Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48614A3CA4
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 03:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243955AbiAaC6t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 30 Jan 2022 21:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242992AbiAaC6s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 30 Jan 2022 21:58:48 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149CEC06173B
        for <cgroups@vger.kernel.org>; Sun, 30 Jan 2022 18:58:48 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so11052236pjb.5
        for <cgroups@vger.kernel.org>; Sun, 30 Jan 2022 18:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UKwameRoPfgLHWpBXoqOSY31hKTED2y4WM3/cMREqYQ=;
        b=ie36z+3JbZH6BpcGWoA8u8BouUWN7xsL3fl1f4YoG1CTP82izOviQ8uJeRSWesrmi0
         SdWI6A0H7yGOF4A02a4ZCDGnvB8dgzI0l6WNB2l6lcim35Ft20EXinLNlIA2m0HzJZro
         iWeB2iq9vReukiu+pPL2Qswox9STXWvm1FfDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UKwameRoPfgLHWpBXoqOSY31hKTED2y4WM3/cMREqYQ=;
        b=6Z2hoVhKr5WLDvwd8j1o9TFUJsEm/j0Rv6lsLJ8k0vQSqNGe6CZhPUjw1Et21ZhAe9
         FyWoyLFKza+qAACvJQmxG62phe8zyJ9NbCr34xGpx2/wNgwXAte5vjk202mmtNewEUl4
         tzyc4iM22ptoWRcrK2OW5AZ+b7uijVUaAvCfUPLh6qVRB1pqKnubUumGPUv7l/GMkZdA
         013e0t+WOqqTlQMQVzPfz4k7Xlyrkect5Cv40gAUwODGuLo5PH0ZLIHXmjojdSHXW6GQ
         yBizeHtv+EeBImanPO04zqDUaXZY/b1lnWUonZW9ixkcGJFTtlgteQghlyGYqvQEGNo6
         P1Iw==
X-Gm-Message-State: AOAM5332ZYETDIIFj7838h5hUYEeENWqcRoVe35ajv+3iV22oiTKf2L1
        QVJ9DR3jZpfwt62hbjoAw3vx4Q==
X-Google-Smtp-Source: ABdhPJzC803twXWB9gJWO7ckQkbQydjauPxbn+wK2Zrz3p/u8T15jAhCVbBRrUJeQ+UwY1smWH5+XA==
X-Received: by 2002:a17:90a:ed03:: with SMTP id kq3mr21942288pjb.136.1643597927548;
        Sun, 30 Jan 2022 18:58:47 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:c6d0:3c7:e220:605c])
        by smtp.gmail.com with ESMTPSA id s30sm5169120pfw.63.2022.01.30.18.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 18:58:47 -0800 (PST)
Date:   Mon, 31 Jan 2022 11:58:41 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2 2/3] mm/page_owner: Use scnprintf() to avoid excessive
 buffer overrun check
Message-ID: <YfdQYdFKdH0WQMVO@google.com>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129205315.478628-3-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On (22/01/29 15:53), Waiman Long wrote:
> The snprintf() function can return a length greater than the given
> input size. That will require a check for buffer overrun after each
> invocation of snprintf(). scnprintf(), on the other hand, will never
> return a greater length. By using scnprintf() in selected places, we
> can avoid some buffer overrun checks except after stack_depot_snprint()
> and after the last snprintf().
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
