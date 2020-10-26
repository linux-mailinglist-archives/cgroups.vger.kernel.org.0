Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6307298E65
	for <lists+cgroups@lfdr.de>; Mon, 26 Oct 2020 14:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780622AbgJZNrQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Oct 2020 09:47:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45726 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780621AbgJZNrQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Oct 2020 09:47:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id 188so8281836qkk.12
        for <cgroups@vger.kernel.org>; Mon, 26 Oct 2020 06:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QpRl8nb/okmu5mxEF73+jt6XHfqyPJBohilPccW7jX0=;
        b=cahbSm9HrLJ2d6FZyd5IykINox1xnvgkhJ0BkJLnnP31WgnC1PDdIzcn8fAOvXdtxC
         s7kKJ6X/SkGJs/f1Q/PjP7KfEWjgJqJu7oHEoxOKulcGYDjQk4ZT9zp9RO/rXkoAGQLt
         zZGs9GMuYOrl837w73p8EikFy9UUVdhy7fhC+cjFEvI9WJQJ6+iIqnJiyg5XAJV3Pikb
         ft6ertavexvL1d8ycx6THkVI2XszqmdAKC2h95QAn+KGOdbjQON259St8Y5zVGTpncR9
         RLaa5tjgP2sXD/Xycvtzdpz49YedMY744Out/6+LhttoDcOTcv6jCxmxLLqjH5n4ZMSv
         BAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QpRl8nb/okmu5mxEF73+jt6XHfqyPJBohilPccW7jX0=;
        b=lHrhmNs2t/8Zwinko0r8Tte2JgB6LMo3EsbObuVk7zrq6LlrPYKVs1LdoNcsorNpKC
         r6LduYMuXjh6QKrkpIbqhTB8wFarYlUDykHtLeI/zvFqeoibkt5RPeYkqAKaU7PsBu1I
         x2hSPgKECwArxDxrVars94TenrlJOR+8dpTZ5krvZ3ZLEFRtwhKiIBi0qjmHTZaTHlLY
         UBqll/7HGj+0pVZ1MtIu349dOHCLwQN3JCV2sGr7HOhrB8ODD5sjMW+C0i++bH7hSsua
         AMeQeVb6IF9CjBIGTT47sPii5hzAFFvCGI47h4FlgxjNYX9LtRrdkarX2m49XHVmTRoq
         jLBQ==
X-Gm-Message-State: AOAM530yYa6Dv8HeabKRhpMnvx+HicGckP3MnORGM3T2luyr61vuT7xV
        mJ3bEmVEKZuaY0dt5oemyO0=
X-Google-Smtp-Source: ABdhPJzPRJ9Ij/nqSeChGuHZITXa+RBITupO/PChffmgGNyUEwaAFnIlg5Q7eADHsmPCtwkyK0cMAw==
X-Received: by 2002:a05:620a:15f1:: with SMTP id p17mr17976695qkm.349.1603720035267;
        Mon, 26 Oct 2020 06:47:15 -0700 (PDT)
Received: from localhost (dhcp-48-d6-d5-c6-42-27.cpe.echoes.net. [199.96.181.106])
        by smtp.gmail.com with ESMTPSA id 128sm6329281qkm.76.2020.10.26.06.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:47:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Oct 2020 09:47:11 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        yangyingliang@huawei.com
Subject: Re: [PATCH] cgroup-v1: add disabled controller check in
 cgroup1_parse_param()
Message-ID: <20201026134711.GB73258@mtj.duckdns.org>
References: <20201012102757.83192-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012102757.83192-1-chenzhou10@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 12, 2020 at 06:27:57PM +0800, Chen Zhou wrote:
> When mounting a cgroup hierarchy with disabled controller in cgroup v1,
> all available controllers will be attached.
> 
> Add disabled controller check in cgroup1_parse_param() and return directly
> if the specified controller is disabled.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>

check_cgroupfs_options() is already checking the condition. How does also
checking in parse_param() help?

Thanks.

-- 
tejun
