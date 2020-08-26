Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B485253149
	for <lists+cgroups@lfdr.de>; Wed, 26 Aug 2020 16:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHZO21 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Aug 2020 10:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHZO2T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Aug 2020 10:28:19 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780B5C061756
        for <cgroups@vger.kernel.org>; Wed, 26 Aug 2020 07:28:19 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id m7so1973254qki.12
        for <cgroups@vger.kernel.org>; Wed, 26 Aug 2020 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xk5PuaZ3h09SHfotxUuVEcyrelgIx31zSBn5gXVN9IM=;
        b=OF5msf8xUCmN3Dyr5IsRi7XjXqiObhM2vxPE0Wx6z73yQzocQZyXZsVr5xG0GxVewc
         8mLHzkVTThC3XbmKu2Oa0VF7cELOHQSCp/cqw+5vpnsG3VZHJvXAr+JOvrRE6R63MecR
         5eKN8lU7SEwLqjplk8sot+PoejbjUxEv8shqxLgH73nW3b2ndtpOW1dPSVhhoQHC5XxK
         PdD3gTbsv7nty7LeKQllTit9Ov259nDQt7vZU9yH1d6KPkehzqy90/rxUJUFDOLY8VkC
         R2+yVQgS7FhIexvx3CAo8IWgUcOwpwxqj9aIgTPNL0TCgX8H7T0yWCtFyDa7/BtXGVhx
         sMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xk5PuaZ3h09SHfotxUuVEcyrelgIx31zSBn5gXVN9IM=;
        b=GsgrQXz5ObpZ/2BZlMMUvk5W9sr9FFDBi1jniyfaaGM170D+pi3SCjyHDRyEwFrCuQ
         FSOPUtCii+QyeMcZo2QkpxNIB5wWrcRRzFv7lixlJYd1N+rkJX8gROScSn94QInbURSl
         X+18lhWCZS4yGvb57JKk+BZ7A3NcrShJF4xNxaj+Cf/RsEjeXGzuSIDHbC2T8wFdo9q8
         +s8Cy8gttvgtEKF5eOZPegtGbEE7UR/I4kehI7PL/PC0gBLcbdI/QTq0PhyKlagRdTkY
         cyVyAEAHG95o0cH2VgJiA3hVQjK+y8iHE8Xcx5XHt9/t4w9jIqQTbjAgcIYQmgahAI/l
         ZO/w==
X-Gm-Message-State: AOAM531aQZRa0N4NSzroRxLhgpxo1SC7M1M223Ldww/ix1Rv2tVhFQr0
        1IC810j+DqTro4YngXuQ3qmJyQ==
X-Google-Smtp-Source: ABdhPJwTpEodJr7XmJ6vcGG/Qy1YoTKLrAkKtGQKZLh7Xqi5GwYySJHucKowPQ2UWvg/JqRFErD0OQ==
X-Received: by 2002:a05:620a:1257:: with SMTP id a23mr13959682qkl.207.1598452098795;
        Wed, 26 Aug 2020 07:28:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:1f2b])
        by smtp.gmail.com with ESMTPSA id v136sm1814940qkb.31.2020.08.26.07.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:28:18 -0700 (PDT)
Date:   Wed, 26 Aug 2020 10:27:03 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] i915: Use find_lock_page instead of find_lock_entry
Message-ID: <20200826142703.GD988805@cmpxchg.org>
References: <20200819184850.24779-1-willy@infradead.org>
 <20200819184850.24779-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819184850.24779-6-willy@infradead.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 19, 2020 at 07:48:47PM +0100, Matthew Wilcox (Oracle) wrote:
> i915 does not want to see value entries.  Switch it to use
> find_lock_page() instead, and remove the export of find_lock_entry().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
