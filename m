Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F9848CCF1
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 21:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbiALUPM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jan 2022 15:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357397AbiALUOj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jan 2022 15:14:39 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405EDC061756;
        Wed, 12 Jan 2022 12:14:39 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id hv15so7299870pjb.5;
        Wed, 12 Jan 2022 12:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rmc9nZh5Lq0NuEYLrcILVtw0HQa1oGMKkH5BAZ9bgf0=;
        b=HVXOgy3P/tNrTaSec1EwDq6ftH01QJGPUkpDBvb/XQxYHgT2/zL/fmJCQahK0JFQDQ
         20A2ZBj9n2jTrv7KuepLM9ZCuXF0UcxiLIVkuMey1CPpYK+vJNjTKSmhhb5hwEWI4XRZ
         nn8zAh/Iea/Bw/+9isy3jE3PVZsq+Naj8r1OMI0dKcaYIkPv1eKzGXL+JYGaPTcTzM3P
         qexr5+fySbDPqSQuqaoxCsXdsRig+QXmamZtpeNLhHTKqOKdiquiWstCUaagrZLlqM1o
         d7MTfA8y6mqu+yRx6Yp6y8QFcDT3jq83sTsNVHNg2h/yD+3s6c0vUjpe0wKZZA1pWTRD
         uWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rmc9nZh5Lq0NuEYLrcILVtw0HQa1oGMKkH5BAZ9bgf0=;
        b=8NF1W3C0VX4esqNUhTFD+qcnAnL2LGt0gUsk7WwFhiM0RF0s+h08wgulHPRUDfxX9A
         C9qNnwBLaBzUxZ91byjOStw7kkuPcePzL9PpelvbLl2PLW9DPqmisiL6OwuXElPalWKO
         wnodo6jtJV/k360r0lQY928BegPKXXP1mpMA1a6LHQmMliyg7z13Jri7W71OB7mIlIMQ
         q82KrLwwX4t2Oj9iifukB2Mbgjk+aL0sbMT6mERZpB4nw0x30tGIs5GZFqxsnN05Vvrs
         dPlapCmjrt4CPsE2278Ml5Xk41oTwLrI7TQFBS2C8HW5ZYj4q90IHeDsmRCko8OB7KRu
         vMoQ==
X-Gm-Message-State: AOAM531TVbSUGjsFS3iKHEDolqrpGV51nvaL9K4ASuTXqQ4OHDg+VS+N
        i2Lkw2y8DgRFcF6UUanjVlY=
X-Google-Smtp-Source: ABdhPJynA6+huSbdIZ0m2kRdfbFhlbDmj/q7j3NwR6spgOTiAMFKUmZeY0OGovCUJKT1J+WKWae3qA==
X-Received: by 2002:a17:902:7202:b0:14a:6b9:ce33 with SMTP id ba2-20020a170902720200b0014a06b9ce33mr1378616plb.124.1642018478672;
        Wed, 12 Jan 2022 12:14:38 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id b6sm419574pfm.170.2022.01.12.12.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 12:14:38 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Jan 2022 10:14:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wolfgang Bumiller <w.bumiller@proxmox.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: [PATCH v3] blk-cgroup: always terminate io.stat lines
Message-ID: <Yd82rHFwf9XQ9Gwu@slm.duckdns.org>
References: <20220111083159.42340-1-w.bumiller@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111083159.42340-1-w.bumiller@proxmox.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 09:31:59AM +0100, Wolfgang Bumiller wrote:
> With the removal of seq_get_buf in blkcg_print_one_stat, we
> cannot make adding the newline conditional on there being
> relevant stats because the name was already written out
> unconditionally.
> Otherwise we may end up with multiple device names in one
> line which is confusing and doesn't follow the nested-keyed
> file format.
> 
> Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
> Fixes: 252c651a4c85 ("blk-cgroup: stop using seq_get_buf")

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
