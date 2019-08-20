Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D0996404
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2019 17:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbfHTPTI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Aug 2019 11:19:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44270 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730356AbfHTPTH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Aug 2019 11:19:07 -0400
Received: by mail-qt1-f193.google.com with SMTP id 44so6417395qtg.11;
        Tue, 20 Aug 2019 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c+ytF9JRpx+c+jH7VEntcNHapqJkhUT6uddNW8eq0CI=;
        b=j/1N4ekm9zWh5OV8A5seiIkduZDfjViU9YztBjbBDi/ScXALSStzfFPCDm2ywBgFj8
         AORxFbVW4sevVDpQebSL2W1ZojiMi+XLadvgTE3WCgc7EXGi+LOyEqH8QbHkcuPB8M6w
         IUTsf8zPnnBepJEIZ/O4HkfQjDt4ZNMqlk3lL6TsEqpC208NnZkb26y6clD8vPNbUxpF
         nzYJe9/TAMcTTEx4+jtfLT5n3UfKgN64VgK23qGqtcjtUVCFIZP5TO7t2fS5zVa60L80
         1h+LaGlzWQF8Gzp8ZMe7GR4lpBYwpXxxGot+HkJHKIGWwXc7E45B5XlcOCUfhxLDy/5c
         DxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=c+ytF9JRpx+c+jH7VEntcNHapqJkhUT6uddNW8eq0CI=;
        b=ZRaxFO9Q6GxP22hyqnP8HHrnzhKb1imJyGJUNGpPfFcBOar79PjNgw1tfcD20RbTDb
         WJFyASzegDgrS2J18/ZpXEyAgjU5JzeRLxjbkbk6GtC2PTqBzjzaV2f6DiAsutKlEhHv
         BAkurQlVnM0+eWWWAKzenZGr8rAZ7riD2F+Ep2XZzro35Sj4kXVzKpCn19VbxTokBnZf
         LbiJw/8MFbEIwDvB4pBLcJIT4pUTCby9o4Gf1skXWoBU/mMpjIXMHgug50XVGLv62j20
         jDLIc5LySRy4jydgUyUhpFwddxySLiGZHQ3SuweT7Wm6XeZBf/2ZNa3LIo+ST/ufXBOl
         CpBA==
X-Gm-Message-State: APjAAAUTj+ZqbYoBhGG9ulwNyAwQIZSciH2eIkULBWyszSrk9duT0c+/
        i+HbSkU+9GKiFlARk5jCDJk=
X-Google-Smtp-Source: APXvYqyWuXwXMjQGCXY671Qo8mOEainLlVJu27sHZeN0PwMV+DobUfF0v5Dvll39J+tn5aaHlVKmpw==
X-Received: by 2002:a05:6214:130d:: with SMTP id a13mr14780230qvv.113.1566314346304;
        Tue, 20 Aug 2019 08:19:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:4c8f])
        by smtp.gmail.com with ESMTPSA id m9sm8417177qtp.27.2019.08.20.08.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:19:05 -0700 (PDT)
Date:   Tue, 20 Aug 2019 08:19:03 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, newella@fb.com, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dennisz@fb.com,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        bpf@vger.kernel.org
Subject: Re: [PATCHSET block/for-next] IO cost model based work-conserving
 porportional controller
Message-ID: <20190820151903.GH2263813@devbig004.ftw2.facebook.com>
References: <20190614015620.1587672-1-tj@kernel.org>
 <20190614175642.GA657710@devbig004.ftw2.facebook.com>
 <5A63F937-F7B5-4D09-9DB4-C73D6F571D50@linaro.org>
 <B5E431F7-549D-4FC4-A098-D074DF9586A1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B5E431F7-549D-4FC4-A098-D074DF9586A1@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Paolo.

On Tue, Aug 20, 2019 at 05:04:25PM +0200, Paolo Valente wrote:
> and makes one fio instance generate I/O for each group.  The bandwidth
> reported above is that reported by the fio instance emulating the
> target client.
> 
> Am I missing something?

If you didn't configure QoS targets, the controller is using device
qdepth saturation as the sole guidance in determining whether the
device needs throttling.  Please try configuring the target latencies.
The bandwidth you see for single stream of rand ios should have direct
correlation with how the latency targets are configured.  The head
letter for the patchset has some examples.

Thanks.

-- 
tejun
