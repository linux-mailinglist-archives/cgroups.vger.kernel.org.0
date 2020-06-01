Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112531EB05D
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2020 22:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgFAUmS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Jun 2020 16:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgFAUmS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Jun 2020 16:42:18 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA9CC061A0E;
        Mon,  1 Jun 2020 13:42:17 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z1so8906297qtn.2;
        Mon, 01 Jun 2020 13:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nNZfm4KTFqe5hnlvYWDeBhcm8Ap+9mpyPFYJmsznAkM=;
        b=t8euN+bSgRmxO9c8Y/F883WBGe4+MHcPeJWqbsm/Ga9gEIjuGubgttCJNl+uoAu4f2
         WA3zDSPL6rLppywjj2lYh+yOrJLiGEntBUcihOjGwVwoOB+VIdBpDFHsUZKyLfQ2mqYV
         RDtckfLXaIynwN3PFlN6VbNxg0/5w0I5jj3n0pEQotS8YPJ9NtJpK3PpqYr1y6OmuR72
         DP+i/gUVvc8ImBV86uzJB2jknfWCq8ei32IFzdQbXhYFDor1nFtNyNC6g3NI2o2ixNLx
         YX5Ej8xkJ/zLmgnXpj7IkDsfKCsuw621xmaC5Ff+cxGIH9ky6fFxr9V1lwO1sDKFQMHm
         flMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nNZfm4KTFqe5hnlvYWDeBhcm8Ap+9mpyPFYJmsznAkM=;
        b=JE6l962Prn65mv1+H2SADpseIXTG0FNZ0wG+UXE5UxXlN7TRWAm9vGI8eeOjdbua9p
         uabuyBABIM8rQWlcLn0x+OLccrp4QNHTfOdaUS/LQPSsxgZX7AY1ks1S/bFLO2odNMWl
         1/fciK+qPIEtvYHh5dI52vd60QAsbzVJMIEw0LZtiunfkuWj6/2OF69fEmGHgNRIpNyZ
         eAxnEq+VBaCHXPyQGJ/Hc3/vI0h2WeGyyWXvKwGHoCR1cUXhAqYY172ABQn14vFMLXc8
         fbvRBfy3iJeckrSCT0yJE8a44nD+KpbUAmKWSI8JuG8fKRUyhf/XfjHeVUZNjzorD3Rq
         TA7A==
X-Gm-Message-State: AOAM532ntUELCTL72A5oMA2mgWFBb59c3yUfX/xywJOPXmOz02DWHVw5
        HsXXs0glLGrhBvhPSQ6SfLWQlFAY
X-Google-Smtp-Source: ABdhPJycDkD6/AfqKFyakBBoPe7y+t2QIAOFQeVj3fFguo76Qe7tXaBmURSRECa9qRKObF/ju+mqBA==
X-Received: by 2002:ac8:f79:: with SMTP id l54mr24298287qtk.79.1591044136879;
        Mon, 01 Jun 2020 13:42:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:eb8b])
        by smtp.gmail.com with ESMTPSA id d23sm434611qtn.38.2020.06.01.13.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 13:42:16 -0700 (PDT)
Date:   Mon, 1 Jun 2020 16:42:14 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Boris Burkov <boris@bur.io>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/2 blk-cgroup/for-5.8] blk-cgroup: show global disk
 stats in root cgroup io.stat
Message-ID: <20200601204214.GF31548@mtj.thefacebook.com>
References: <20200601154351.GD31548@mtj.thefacebook.com>
 <20200601201205.1658417-1-boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601201205.1658417-1-boris@bur.io>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 01, 2020 at 01:12:05PM -0700, Boris Burkov wrote:
> In order to improve consistency and usability in cgroup stat accounting,
> we would like to support the root cgroup's io.stat.
> 
> Since the root cgroup has processes doing io even if the system has no
> explicitly created cgroups, we need to be careful to avoid overhead in
> that case.  For that reason, the rstat algorithms don't handle the root
> cgroup, so just turning the file on wouldn't give correct statistics.
> 
> To get around this, we simulate flushing the iostat struct by filling it
> out directly from global disk stats. The result is a root cgroup io.stat
> file consistent with both /proc/diskstats and io.stat.
> 
> Note that in order to collect the disk stats, we needed to iterate over
> devices. To facilitate that, we had to change the linkage of a disk_type
> to external so that it can be used from blk-cgroup.c to iterate over
> disks.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> Suggested-by: Tejun Heo <tj@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
