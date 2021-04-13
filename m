Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E051835D7E3
	for <lists+cgroups@lfdr.de>; Tue, 13 Apr 2021 08:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240558AbhDMGVo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Apr 2021 02:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344956AbhDMGVn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Apr 2021 02:21:43 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930F0C061574
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 23:21:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so10141167pji.5
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 23:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7kAWcxxGaZDdCTj+s71PpqO4XR9FwpgXo0FGzfVw7hk=;
        b=eL9auHf68NXfFnDkcsjCpMCXrh5rvNxRLJssb7wVGWq/DcUdBrdZi7TvMDF5juIEn9
         QKhGGDcAGNKNIdQNdKreXHn/xc5ooDuPoTGiOxGA1aPznQehg7PU3JAYGTOc0g25hj7B
         9dcsd0bRiviK9J0bW6h5prbTdBvqZJIQ6Up+dtkkMXycBNXkl4JEJPp9KCXvc4GgPx/x
         sSA+ISxQehVD0yb7rVVwH+OUfBzI7SJdecrJ2VFi6Zmbr8MktOcl/N/+JAtxpJuzG39f
         eQ+akmaUIrEOAGJ4sdVeKdeeLL/dG23HnuF0VvR0qm0CxrL90LtBwLcn8ATwzjS92tJX
         JtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7kAWcxxGaZDdCTj+s71PpqO4XR9FwpgXo0FGzfVw7hk=;
        b=FRlPnfmRuMA3VvPKdiDgaOk2KWdnhUXd5MfEWoOC2BcgGMx5IEYFyazxiA90XsTYuK
         2MRZeKdMNaagCLI8o0MX8oUL7dLefXYZ+E3JbfApj0lW9HoPVysn6qLj+TEwRaDyobnO
         1lhbIyVhRxBoFRBkj62awWMGp8e2gQyNr21Z7LugWQMVOu7gIYtd0o5D8xmxThkppBTM
         ih4viMkrO4J/fpwK2Fb4DzJzkmNF9+O9ODCfNK7Q8rc3kwf2nj+ZO+oV2QRkvS72WKVz
         Hm//unw2Xn4RiIWQZqmrTEo5LBr2pRwUVT45/Q5imzCcwVEtD2qpIeehiXsIIxgFnlRm
         wxYg==
X-Gm-Message-State: AOAM531eCOLU193osEmFfwOg0QW9YNUgodjolYMszntFT7CIGYAJUiZw
        1b6zqkbUKSuWoyZnx1HecMDfIhDrL1dSz/Yg
X-Google-Smtp-Source: ABdhPJwlBlRc8ggvJMcMFBZNOpx9vB9bbIB88OGie4zN2YkXRRqvWbXXeMKJH/nHXicR/i8SBQjxxQ==
X-Received: by 2002:a17:90b:3507:: with SMTP id ls7mr3062256pjb.172.1618294882964;
        Mon, 12 Apr 2021 23:21:22 -0700 (PDT)
Received: from google.com ([2620:0:1008:10:51e:b68b:7b4f:45ec])
        by smtp.gmail.com with ESMTPSA id d17sm11244382pfn.60.2021.04.12.23.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 23:21:22 -0700 (PDT)
Date:   Mon, 12 Apr 2021 23:21:18 -0700
From:   Vipin Sharma <vipinsh@google.com>
To:     tj@kernel.org
Cc:     kbuild-all@lists.01.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        David Rientjes <rientjes@google.com>, lkp@intel.com
Subject: Re: [cgroup:for-next 1/5] kernel/cgroup/misc.c:61 valid_type() warn:
 unsigned 'type' is never less than zero.
Message-ID: <YHU4XrOW1dBIZfVl@google.com>
References: <202104131244.3qFwbTtx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104131244.3qFwbTtx-lkp@intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 13, 2021 at 12:30:50PM +0800, kernel test robot wrote:
> smatch warnings:
> kernel/cgroup/misc.c:61 valid_type() warn: unsigned 'type' is never less than zero.
> kernel/cgroup/misc.c:210 misc_cg_max_show() warn: we never enter this loop
> kernel/cgroup/misc.c:257 misc_cg_max_write() warn: we never enter this loop
> kernel/cgroup/misc.c:299 misc_cg_current_show() warn: we never enter this loop
> kernel/cgroup/misc.c:323 misc_cg_capacity_show() warn: we never enter this loop
> kernel/cgroup/misc.c:376 misc_cg_alloc() warn: we never enter this loop
> kernel/cgroup/misc.c:376 misc_cg_alloc() warn: unsigned 'i' is never less than zero.
> kernel/cgroup/misc.c:376 misc_cg_alloc() warn: unsigned 'i' is never less than zero.
> 

Tejun,

Should this be ignored because MISC_CG_RES_TYPES is 0 as no resource is
defined but the code has 'for' loops and condition checks which are valid?

If there is a way to fix these let me know, I will make the change.

Thanks
Vipin
