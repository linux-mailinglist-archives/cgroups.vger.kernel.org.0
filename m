Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2152FBD21
	for <lists+cgroups@lfdr.de>; Tue, 19 Jan 2021 18:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389825AbhASRC3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 12:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389382AbhASRCS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 12:02:18 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C4BC061573;
        Tue, 19 Jan 2021 09:01:38 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id c1so14188858qtc.1;
        Tue, 19 Jan 2021 09:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d9RwYmgW6Bw/x+i8K3b7UwUNrT1DO+cCS+WHqV/0mmg=;
        b=lc2Rzc4LbffJJrRScBksiaMNyeypxLTvWPLOHTedfhonvrLr4slh8hatcq6SyLaEZX
         xTu9+xDJH8IgDmnipEuaYXRc1rBmFtmxyXRGzjDuzsKq38rjPVFQ2pmQNDSXvtA3GMAy
         yLnyIteFNXL+SP+j6w2TbKzOtgt/hMLP8VYEuQSP6YTy5l1cUR/f5kmsaM/pbiP/2xeg
         R2kphuB0YUpqzaFBkCbWGd3snDK24IwcnOEkaHFKS5HkDH+ez9CspTJzMNhqS8qBv4z0
         PlrKg1+n1sZAO+ozqj6NjZzuIHevfbzGl3Hg5TlcZvnwOhVCdZXrs/jsnTEpW0MQrmac
         s3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=d9RwYmgW6Bw/x+i8K3b7UwUNrT1DO+cCS+WHqV/0mmg=;
        b=LSjFcbOSuvPN8TGIRpiZh+VgysNw+fvSZjgVLATDABs3Ul7rk18nJMUrZoCmwz3gxx
         QYKWRCYRKTyH5y/Zwf19ud+s6eF5Z65sZzoGyNiqi01EeZWNOYog7Nm3gKOTIjmCxrS0
         5Kv772osntukekTpRIR3qZr7eDXTHhyqxyzxAAutRHvs+UJ5i9Yop1XaXbA/cH/8BqAg
         xkIeX/FJk2Qpvx5yHLtSL0ybqn06Mg4H6oFKtkDkVl9ntnwfxCFONhQxDIcKohwprx5g
         OXPy47hJkZKTtwkHLiwHntavwIDIwBeTPGs86MbxlGWx0skBy7kUs1h86NCxtI5/rftU
         kOxQ==
X-Gm-Message-State: AOAM5334FsKaK8UElpXoyI9DcVzmlS2Jo4O0tQSLO0bC8rm5imhdPYKM
        suqMeQpWQoMAs7jVZp2819k=
X-Google-Smtp-Source: ABdhPJzHkFliUU+m2gO7DK4IkzHu+tPhfsotuLNp5vlvIqRmkecOjVqeACDhQ2i55AdrrWeyUWYycA==
X-Received: by 2002:ac8:7546:: with SMTP id b6mr4979935qtr.219.1611075697161;
        Tue, 19 Jan 2021 09:01:37 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:4cbf])
        by smtp.gmail.com with ESMTPSA id i17sm12758143qtg.77.2021.01.19.09.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 09:01:36 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Jan 2021 12:00:51 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Odin Ugedal <odin@uged.al>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, dschatzberg@fb.com, surenb@google.com
Subject: Re: [PATCH v2 0/2] cgroup: fix psi monitor for root cgroup
Message-ID: <YAcQQ15WE8RcgzrE@mtj.duckdns.org>
References: <20210116173634.1615875-1-odin@uged.al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116173634.1615875-1-odin@uged.al>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jan 16, 2021 at 06:36:32PM +0100, Odin Ugedal wrote:
> This patchset fixes PSI monitors on the root cgroup, as they currently
> only works on the non-root cgroups. Reading works for all, since that
> was fixed when adding support for the root PSI files. It also contains
> a doc update to reflect the current implementation.

Applied to cgroup/for-5.11-fixes with acks and stable tag added.

Thanks.

-- 
tejun
