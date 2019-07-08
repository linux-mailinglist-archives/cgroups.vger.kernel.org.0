Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD998620AB
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2019 16:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfGHOlY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Jul 2019 10:41:24 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:38094 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbfGHOlY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Jul 2019 10:41:24 -0400
Received: by mail-qt1-f172.google.com with SMTP id n11so18231019qtl.5;
        Mon, 08 Jul 2019 07:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kXUN90sDFULd4qRU/R3KEOn/usuVWjJoGJ35nR0nQ18=;
        b=Xl9uEj6Og+rO1HLpisU7MOQS4uv+UWSEBNNTBNCnDepQBNXTF8mBQpk9jo/3wdKibZ
         CtZ5kQkMen21+OKQuJ+PCew8yXZuL5r+BgvKpLxdZM9mmLPQ+IYG6A+qUCJCGIEZ8tnH
         reW7Nkw1QthoOFm1CoYBce4mMtko7w8uWB1P05mMGNTOsZXKHk1cluXKkadnDTJGwCBm
         IGzeblqdEzm5X4MFpL3O715NYXJ49/og3rViPEBVtXDCIra2D+aJBBXOv9Wf8sSq/MwJ
         Z+c7nb/En3PazH06XUDEysCWZsK/YpFDRy6/xAUpmjPARQnRlTG5Jc/8fnHOcuzk4zWR
         REOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kXUN90sDFULd4qRU/R3KEOn/usuVWjJoGJ35nR0nQ18=;
        b=k+0pISdu7F130TrTO4mCoz5vkU3z7TH7JDaABJEHfm7Kok9vMYBBX91Rrpy9IY65dq
         meUM13XhZMBJ/lcu4GAKCHBD7/QsBEqXb9n2TTxeZX0lvQfOg/vqP0YUcFPvyCb7wwn8
         0Vll0p7bKo4Nhe4WguZstmCy1tw+tHv4JqX+3fhLwN940v/xs+XhlBNOZDI6muFVTTuB
         zLYQoTIb6zcVQN1pOuamZi4GYHrCDhXJCYYWpUKfv/OZ8420uremGNztC7JM5GbQTyQA
         CIOwVQl2ltGQ28Rt7Ca8t9sRHP6WbZ9vJU6GYmxn6LKVGMT8AjdJHP6CnO3cHHfyxtwG
         XQbg==
X-Gm-Message-State: APjAAAVsLA31yXLimn7rAcA3CEE1PAJSmIkHoDoVYT7SxzOLtsIgBxSj
        K8iDcrxMbcvjyWve7VgpK1U=
X-Google-Smtp-Source: APXvYqzWtXVq70kcEBCAF1m2IUspOBnTrPdr4XPMk3W1jFGF8Wj2K0zHDvWCYUCXGwEsoLQ0eBJRtA==
X-Received: by 2002:ac8:3449:: with SMTP id v9mr10281942qtb.163.1562596883530;
        Mon, 08 Jul 2019 07:41:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:fa50])
        by smtp.gmail.com with ESMTPSA id g3sm7342207qkk.125.2019.07.08.07.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 07:41:22 -0700 (PDT)
Date:   Mon, 8 Jul 2019 07:41:21 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Peng Wang <rocking@whu.edu.cn>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: simplify code for cgroup_subtree_control_write()
Message-ID: <20190708144121.GA657710@devbig004.ftw2.facebook.com>
References: <20190708130132.5582-1-rocking@whu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708130132.5582-1-rocking@whu.edu.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 08, 2019 at 09:01:32PM +0800, Peng Wang wrote:
> Process "enable" and "disable" earlier to simplify code.

I don't think this is correct and even if it were the value of this
change is close to none, so nack on this one.

Thanks.

-- 
tejun
