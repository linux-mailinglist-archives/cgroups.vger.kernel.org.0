Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 847E39D12D
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2019 15:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbfHZN7S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Aug 2019 09:59:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36689 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731297AbfHZN7R (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Aug 2019 09:59:17 -0400
Received: by mail-io1-f66.google.com with SMTP id o9so37472824iom.3
        for <cgroups@vger.kernel.org>; Mon, 26 Aug 2019 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HZ5+cm8oDGl9y7yBYTWMqRdFKjeGGqeRgHWdEMhzSsw=;
        b=c80aseIwaJV0ASqHmXiAVw59RoXvUUaEsL1tMrAmSu40HsButu6rq2Gj0CwjrLkiMF
         +0T4yP2gwaA0QMWgjR3idAX51delKj08+kYC7eyvr454TqC7/v6EALIni538EYlR45fW
         BMsOhTnHEhGN4YNraEjCsWTqyNZeAlkqCkQdB7dWPBaUuowqyn7om1itPED5NsWl9waj
         dYULOL86V6uykIjjS4DhBEqQk0Ujdp/DEk+t2m33F9Ipg6yN/MVmbvr3RcuorJOK0MbP
         HOdAQSuk8iW/4ro/6N6j+21PJhEINl0t4b6HunVmSNCIEpQsaI2c2TusbzERoooLWRyf
         xhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HZ5+cm8oDGl9y7yBYTWMqRdFKjeGGqeRgHWdEMhzSsw=;
        b=sRkpt+h3yxiVhfbA3s+y0y7crhYklILeH9JDDEln/fSQIOEwzyzxKd/ypW1FEKM98D
         3fgr5AZpKkBVz+fwAW4MDzsqIFn4/bHIw/avwF//JVlO+WU5QPWnQJq6MPfZh+3zgWZ0
         084sxFytQtThwEzEoRO6XD5gdngg6solj06dP3KIyy6KJb8zG/0mm0qNzh9ehTRu0MTd
         YVr3cF/fWIDTHHROFV/XBsHzRGWH1zkK5EPc1FRcphUAnBTP4Cv95fApUN81HA+ZRGch
         ii7gzh0PJKkaNEcPpx5kjKX5itdbWgWPt+FMv07vGXIuhaiXHywkCpErVDDbfwqkGxbU
         iWXg==
X-Gm-Message-State: APjAAAWYo54S7pfNeF5PmOuZC+YfmexCtyx8MFDtjfGYvYT1dIbqsQNn
        L5TJ9fZntuhNnUzuow9m0qwKVw==
X-Google-Smtp-Source: APXvYqxsoPCPeSgpdUMZt1/AuxahBNZgEiTDX9WR6Q7MRgICyOdbpgFi1TfU8vU5EWfgSY8nktdgvQ==
X-Received: by 2002:a5d:8f8a:: with SMTP id l10mr23666295iol.306.1566827956999;
        Mon, 26 Aug 2019 06:59:16 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k7sm10354777iop.88.2019.08.26.06.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 06:59:16 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] bfq: Add per-device weight
To:     Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>
Cc:     Fam Zheng <zhengfeiran@bytedance.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fam Zheng <fam@euphon.net>, duanxiongchun@bytedance.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        zhangjiachen.jc@bytedance.com
References: <20190805063807.9494-1-zhengfeiran@bytedance.com>
 <20190805063807.9494-4-zhengfeiran@bytedance.com>
 <20190821154402.GI2263813@devbig004.ftw2.facebook.com>
 <C2F0BE1E-9CAA-4FBD-80D8-C18ECCE3FD4B@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fff76a58-65e7-7060-0329-aef15c422639@kernel.dk>
Date:   Mon, 26 Aug 2019 07:59:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <C2F0BE1E-9CAA-4FBD-80D8-C18ECCE3FD4B@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/26/19 12:36 AM, Paolo Valente wrote:
> Hi Jens,
> do you think this series could now be queued for 5.4?

The most glaring oversight in this series, is that the meat of it,
patch #3, doesn't even have a commit message. The cover letter
essentially looks like it should have been the commit message for
that patch.

Please resend with acks/reviews collected, and ensure that all
patches have a reasonable commit message.

-- 
Jens Axboe

