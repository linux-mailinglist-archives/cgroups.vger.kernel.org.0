Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B23872295
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2019 00:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbfGWWse (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Jul 2019 18:48:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43379 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732011AbfGWWsd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Jul 2019 18:48:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so20120404pgv.10;
        Tue, 23 Jul 2019 15:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gcrDqc/0FKS5RAGoI3p47RWGgYc/38e7wO91/0hzW9U=;
        b=n9wK/DguRoFLTGgPSdnP/e65lyKdLvrZMutcIUo7uorMIpKj5yNx57aNEU/oNupI1o
         HbXUdM405Zpkdvwzm0PuesmMRixcYEnsOdcCUNq/mT0Z6p1JSc/OgcF5lHnzAWAXqrK7
         KsFfrCfYVziAaAmorTCFGKMkHNEvZoiR4N6a/UCU+O9d1OG5PJoNt0D55UC1DM1/VbqS
         iTj0aINX3tGoT4r5QsoDNNwUhmOjy7Z4AoxFSBsRLsabfLn+VCcC9f9YXNl1A0dSqnZQ
         /7bbe4xPXPwriCUiL5uKC86V1x0ipnv5ldTuyXozXPkP1j15LHE0tjB0/O1us2jnNtfP
         PF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gcrDqc/0FKS5RAGoI3p47RWGgYc/38e7wO91/0hzW9U=;
        b=j/48PR0yrXe3GpG87P5sHOLplGPCbbw3UGIEfGNUCmhniFTACXwCl2e8GkuIWetm60
         05JNtZjNZBzKSH08ZhuAcBfy4CSqMnTwu/ivVdZhu6F8uXaP+dsn3HkWn15+XczLTN68
         KDyz07Uw+/dY0ZUPmICO2knO0MZoCEy2i84IbXMo8LxlF8CnEKxCh4ezpso6Q/Zxz3EJ
         ahURFnvNkauZ+gL74rbP7uHKqgHRyZ7Hdak4xQqVcqg2LB1QR3Q+6dFkVYHtFByISU7a
         ag0EsO4JnhKefLw+mkQTXWvHuQhDn9fPq27sXn3gNd1o51Vcob8Vejcg2dduSQ3gv8hq
         JfxQ==
X-Gm-Message-State: APjAAAXfIzeVViQerrNIN8ue/ca5DvFOA9offxbDAv25uMCUNiIPQljX
        MZBQGxfJjSBrrm6pR2F41fF8GQFB
X-Google-Smtp-Source: APXvYqx7huFHP0vuDKUFHptTjAUxEYu+AiEZ/b1zNRdJNqOxHmrz/x5k1j/QPVgGgW2yF0oHYQvYKA==
X-Received: by 2002:a17:90a:2ec1:: with SMTP id h1mr85151553pjs.119.1563922113017;
        Tue, 23 Jul 2019 15:48:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:2287])
        by smtp.gmail.com with ESMTPSA id b16sm69345877pfo.54.2019.07.23.15.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 15:48:32 -0700 (PDT)
Date:   Tue, 23 Jul 2019 15:48:30 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Peng Wang <rocking@whu.edu.cn>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: minor tweak for logic to get cgroup css
Message-ID: <20190723224830.GH696309@devbig004.ftw2.facebook.com>
References: <20190703020749.22988-1-rocking@whu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703020749.22988-1-rocking@whu.edu.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 03, 2019 at 10:07:49AM +0800, Peng Wang wrote:
> We could only handle the case that css exists
> and css_try_get_online() fails.
> 
> Signed-off-by: Peng Wang <rocking@whu.edu.cn>

Applied to cgroup/for-5.4.

Thanks.

-- 
tejun
