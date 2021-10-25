Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CBF439D95
	for <lists+cgroups@lfdr.de>; Mon, 25 Oct 2021 19:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhJYR3a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Oct 2021 13:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbhJYR30 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Oct 2021 13:29:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734E1C061220;
        Mon, 25 Oct 2021 10:27:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso12007095pjm.4;
        Mon, 25 Oct 2021 10:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aCZMd4lnZUOWP3HuMJZrRTDzuvD7CVVCcTZfYmmmVYQ=;
        b=jB5xsxczN9t/FAMcQj8CtRTnmhHtZXcl5SVodMk6K4L0F+P8ivxWvi/7AOYRNNw2c5
         KgPQbGuOcYNZKx1m7ZpDeJVGp9IyLAFuM1H1CS7mMqU+ISDG24Qh2p6Eob0J9QViMiM4
         u9ctfqMNOaSDV55qSmdjPIGyT64q4bwDb4sA/bO1X/PUCNARks1jSVYH+BdU1XvlLLjF
         g/hIj+1qJQAWhQ72vovkRU8MFKxf0eTuqGdobXFdu51L2ZK1vyfZA/GQti8M8RJwq6DV
         9TzFRGA8MWJ0er52eshkuUVcHxxcwY7IHlTAZOqrkJrskNDDBpzTj2Cr2VGyPEXE9fwZ
         37Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=aCZMd4lnZUOWP3HuMJZrRTDzuvD7CVVCcTZfYmmmVYQ=;
        b=cOx3f95/gJ7dgV9empV725HxLC929SZyB+l92T32KPWe05lreQmy1KGcQbxNwsVADt
         yxVV9LA0WN0SzRw1582Z5iixJsH5x5mCtnefg6RRIbxiQBWAToWYgK8QPuLItsGuvRuK
         8FdT/xGUNGTyDdjmxlYUspBz/bDmfX22SbLctrkBCLAaO+nqr11rV+Xprh9wqX5iGmkp
         rwwOpl6cZWuL7OWVtUdbdQVGgYYogvGYIJ+mXdz4+6RduqhT//gELevLk/8OHIy6jv41
         Pm6OeNR0DCYPLs3D2jFCBl71NL8bOvHcDpTeI3SUAC29MfGK8FuTHXEua8DRpJLF/on+
         //0w==
X-Gm-Message-State: AOAM531hr16zM58RX01D+L7gi9F+7VwBtMs5PyRgZJBpouyRmPLpZa7V
        Y4vETOOlMz7RrcbqodItBBwCajVwvzWhUQ==
X-Google-Smtp-Source: ABdhPJwmiPVKv0R8Ef+ST6u2Ao5/iO3yRxb9hxL+s6APNWSvdah+WdOyk2J8yvuVFayQk7ILd/IxOg==
X-Received: by 2002:a17:902:aa82:b0:140:4655:b211 with SMTP id d2-20020a170902aa8200b001404655b211mr9918872plr.38.1635182823755;
        Mon, 25 Oct 2021 10:27:03 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id d13sm21078439pfu.196.2021.10.25.10.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 10:27:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 25 Oct 2021 07:27:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cgroup: no need for cgroup_mutex for /proc/cgroups
Message-ID: <YXbo5sKj0wgPTaMp@slm.duckdns.org>
References: <20211025061916.3853623-1-shakeelb@google.com>
 <20211025061916.3853623-3-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025061916.3853623-3-shakeelb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Oct 24, 2021 at 11:19:16PM -0700, Shakeel Butt wrote:
> On the real systems, the cgroups hierarchies are setup early and just
> once by the node controller, so, other than number of cgroups, all
> information in /proc/cgroups remain same for the system uptime. Let's
> remove the cgroup_mutex usage on reading /proc/cgroups. There is a
> chance of inconsistent number of cgroups for co-mounted cgroups while
> printing the information from /proc/cgroups but that is not a big
> issue. In addition /proc/cgroups is a v1 specific interface, so the
> dependency on it should reduce over time.
> 
> The main motivation for removing the cgroup_mutex from /proc/cgroups is
> to reduce the avenues of its contention. On our fleet, we have observed
> buggy application hammering on /proc/cgroups and drastically slowing
> down the node controller on the system which have many negative
> consequences on other workloads running on the system.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Applied 1-3 to cgroup/for-5.16.

Thanks.

-- 
tejun
